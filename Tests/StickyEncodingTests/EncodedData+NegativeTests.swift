///
///  EncodedData+NegativeTests.swift
///
///  Copyright 2019 Tony Stone
///
///  Licensed under the Apache License, Version 2.0 (the "License");
///  you may not use this file except in compliance with the License.
///  You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///  Unless required by applicable law or agreed to in writing, software
///  distributed under the License is distributed on an "AS IS" BASIS,
///  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  See the License for the specific language governing permissions and
///  limitations under the License.
///
///  Created by Tony Stone on 03/30/19.
///
import XCTest

@testable import StickyEncoding

class EncodedDataNegativeTests: XCTestCase {

    let decoder = BinaryDecoder()

    func testValidByteInput() throws {

        let input = EncodedData([0xd,  0x0, 0x0, 0x0, /// Header: Container Type
                                 0xc,  0x0, 0x0, 0x0, /// Header: Byte count
                                 0xa5, 0x0, 0x0, 0x0, /// SingleValueContainer: Type
                                 0x4,  0x0, 0x0, 0x0, /// SingleValueContainer: Size
                                 0xa,  0x0, 0x0, 0x0  /// SingleValueContainer: Value
            ])

        XCTAssertEqual(try decoder.decode(Int32.self, from: input), 10)
    }

    func testZeroLengthByteCountForKeyedContainer() throws {

        let input = EncodedData([0xb,  0x0, 0x0, 0x0, /// Header: Container Type
                                 0x0,  0x0, 0x0, 0x0  /// Header: Byte count
            ])

        XCTAssertThrowsError(try decoder.decode(Int32.self, from: input)) { (error) in
            switch error {
            case DecodingError.dataCorrupted(let context):

                XCTAssertEqual(context.debugDescription, "Keyed container header missing or corrupt.")

            default: XCTFail("Incorrect error returned: \(error)")
            }
        }
    }


    func testZeroLengthByteCountForUnkeyedContainer() throws {

        let input = EncodedData([0xc,  0x0, 0x0, 0x0, /// Header: Container Type
                                 0x0,  0x0, 0x0, 0x0  /// Header: Byte count
            ])

        XCTAssertThrowsError(try decoder.decode(Int32.self, from: input)) { (error) in
            switch error {
                case DecodingError.dataCorrupted(let context):

                    XCTAssertEqual(context.debugDescription, "Unkeyed container header missing or corrupt.")

                default: XCTFail("Incorrect error returned: \(error)")
            }
        }
    }

    func testZeroLengthByteCountForSingleValueContainer() throws {

        let input = EncodedData([0xd,  0x0, 0x0, 0x0, /// Header: Container Type
                                 0x0,  0x0, 0x0, 0x0  /// Header: Byte count
            ])

        XCTAssertThrowsError(try decoder.decode(Int32.self, from: input)) { (error) in
            switch error {
                case DecodingError.dataCorrupted(let context):

                    XCTAssertEqual(context.debugDescription, "Single value container header missing or corrupt.")

                default: XCTFail("Incorrect error returned: \(error)")
            }
        }
    }

    func testZeroLengthByteCountForNullContainer() throws {

        let input = EncodedData([0xa,  0x0, 0x0, 0x0, /// Header: Container Type
                                 0x0,  0x0, 0x0, 0x0  /// Header: Byte count
            ])

        XCTAssertNoThrow(try decoder.decode(Optional<Int32>.self, from: input))
    }

    func testNonSupportedFirstByte() throws {

        let input = EncodedData([0xf,  0x0, 0x0, 0x0, /// Header: Container Type
                                 0xc,  0x0, 0x0, 0x0, /// Header: Byte count
                                 0xa5, 0x0, 0x0, 0x0, /// SingleValueContainer: Type
                                 0x4,  0x0, 0x0, 0x0, /// SingleValueContainer: Size
                                 0xa,  0x0, 0x0, 0x0  /// SingleValueContainer: Value
            ])

        XCTAssertThrowsError(try decoder.decode(Int32.self, from: input)) { (error) in
            switch error {
                case DecodingError.dataCorrupted(let context):

                    XCTAssertEqual(context.debugDescription, "Binary data contains an unknown container type.")

                default: XCTFail("Incorrect error returned: \(error)")
            }
        }
    }

    func testTruncatedValueSize() throws {

        let input = EncodedData([0xd,  0x0, 0x0, 0x0, /// Header: Container Type
                                 0xc,  0x0, 0x0, 0x0, /// Header: Byte count
                                 0xa5, 0x0, 0x0, 0x0, /// SingleValueContainer: Type
                                 0x4,  0x0, 0x0, 0x0, /// SingleValueContainer: Size
                                 0xa,  0x0, 0x0       /// SingleValueContainer: Value
            ])

        XCTAssertThrowsError(try decoder.decode(Int32.self, from: input)) { (error) in
            switch error {
            case DecodingError.dataCorrupted(let context):

                XCTAssertEqual(context.debugDescription, "Binary data truncated or missing.")

            default: XCTFail("Incorrect error returned: \(error)")
            }
        }
    }

    func testHeaderByteCountIncorrect() throws {

        let input = EncodedData([0xd,  0x0, 0x0, 0x0, /// Header: Container Type
                                 0xd,  0x0, 0x0, 0x0, /// Header: Byte count
                                 0xa5, 0x0, 0x0, 0x0, /// SingleValueContainer: Type
                                 0x4,  0x0, 0x0, 0x0, /// SingleValueContainer: Size
                                 0xa,  0x0, 0x0, 0x0  /// SingleValueContainer: Value
            ])

        XCTAssertThrowsError(try decoder.decode(Int32.self, from: input)) { (error) in
            switch error {
            case DecodingError.dataCorrupted(let context):

                XCTAssertEqual(context.debugDescription, "Binary data truncated or missing.")

            default: XCTFail("Incorrect error returned: \(error)")
            }
        }
    }
}
