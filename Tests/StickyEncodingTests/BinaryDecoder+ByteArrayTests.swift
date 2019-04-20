///
///  BinaryDecoder+ByteArrayTests.swift
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

class BinaryDecoderByteArrayTests: XCTestCase {

    let decoder = BinaryDecoder()

    // MARK: Non-supported types

    func testNonSupportedFirstByte() throws {

        let input: [UInt8] = [0xf,  0x0, 0x0, 0x0, /// Header: Container Type
                              0xa5, 0x0, 0x0, 0x0, /// SingleValueContainer: Type
                              0x4,  0x0, 0x0, 0x0, /// SingleValueContainer: Size
                              0xa,  0x0, 0x0, 0x0  /// SingleValueContainer: Value
            ]

        XCTAssertThrowsError(try decoder.decode(Int32.self, from: input)) { (error) in
            switch error {
                case DecodingError.dataCorrupted(let context):

                    XCTAssertEqual(context.debugDescription, "Binary data contains an unknown container type.")

                default: XCTFail("Incorrect error returned: \(error)")
            }
        }
    }

    // MARK: SingleValueContainer Tests

    func testSingleValueContainerWithValidInput() throws {

        let input: [UInt8] = [0xd,  0x0, 0x0, 0x0, /// Header: Container Type
                              0xa5, 0x0, 0x0, 0x0, /// SingleValueContainer: Type
                              0x4,  0x0, 0x0, 0x0, /// SingleValueContainer: Size
                              0xa,  0x0, 0x0, 0x0  /// SingleValueContainer: Value
            ]

        XCTAssertEqual(try decoder.decode(Int32.self, from: input), 10)
    }

    func testSingleValueContainerWithTruncatedValueSize() throws {

        let input: [UInt8] = [0xd,  0x0, 0x0, 0x0, /// Header: Container Type
                              0xa5, 0x0, 0x0, 0x0, /// SingleValueContainer: Type
                              0x4,  0x0, 0x0, 0x0, /// SingleValueContainer: Size
                              0xa,  0x0, 0x0       /// SingleValueContainer: Value
            ]

        XCTAssertThrowsError(try decoder.decode(Int32.self, from: input)) { (error) in
            switch error {
            case DecodingError.dataCorrupted(let context):

                XCTAssertEqual(context.debugDescription, "Not enough bytes stored to read value of type Int32.")

            default: XCTFail("Incorrect error returned: \(error)")
            }
        }
    }

    // MARK: KeyedContainer Tests

    func testKeyedContainerWithValidByteInput() throws {

        class ExpectedClass: Decodable {
            let a: Int32
        }

        let input: [UInt8] = [                     /// Header:
                              0xb,  0x0, 0x0, 0x0, /// - Container Type

                                                   /// KeyedValueContainer:
                              0x1,  0x0, 0x0, 0x0, /// - Count

                                                   /// key:
                              0x1,  0x0, 0x0, 0x0, /// - Size
                              0x61, 0x0, 0x0, 0x0, /// - Value + Alignment Padding

                                                   /// Header:
                              0xd,  0x0, 0x0, 0x0, /// - Container Type

                                                   /// SingleValueContainer:
                              0xa5, 0x0, 0x0, 0x0, /// - Type
                              0x4,  0x0, 0x0, 0x0, /// - Size
                              0xa,  0x0, 0x0, 0x0  /// - Value
            ]

        XCTAssertEqual(try decoder.decode(ExpectedClass.self, from: input).a, 10)
    }


    func testKeyedContainerWithKeyMissing() throws {

        let input: [UInt8] = [                     /// Header:
                              0xb,  0x0, 0x0, 0x0, /// - Container Type

                                                   /// KeyedValueContainer:
                              0x1,  0x0, 0x0, 0x0, /// - Count
            ]

        XCTAssertThrowsError(try decoder.decode(Int32.self, from: input)) { (error) in
            switch error {
            case DecodingError.dataCorrupted(let context):

                XCTAssertEqual(context.debugDescription, "Key value header missing or corrupt.")

            default: XCTFail("Incorrect error returned: \(error)")
            }
        }
    }

    func testKeyedContainerWithKeyValueMissing() throws {

        let input: [UInt8] = [                     /// Header:
                              0xb,  0x0, 0x0, 0x0, /// - Container Type

                                                   /// KeyedValueContainer:
                              0x1,  0x0, 0x0, 0x0, /// - Count

                                                   /// key:
                              0x1,  0x0, 0x0, 0x0, /// - Size
                              0x61, 0x0, 0x0, 0x0, /// - Value + Alignment Padding
            ]

        XCTAssertThrowsError(try decoder.decode(Int32.self, from: input)) { (error) in
            switch error {
            case DecodingError.dataCorrupted(let context):

                XCTAssertEqual(context.debugDescription, "Binary data does not contian a proper header.")

            default: XCTFail("Incorrect error returned: \(error)")
            }
        }
    }

    func testKeyedContainerWithZeroLengthByteCountForKeyedValueKey() throws {

        let input: [UInt8] = [                     /// Header:
                              0xb,  0x0, 0x0, 0x0, /// - Container Type

                                                   /// KeyedValueContainer:
                              0x1,  0x0, 0x0, 0x0, /// - Count

                                                   /// key:
                              0x0,  0x0, 0x0, 0x0, /// - Size
                              0x61, 0x0, 0x0, 0x0, /// - Value + Alignment Padding
            ]

        XCTAssertThrowsError(try decoder.decode(Int32.self, from: input)) { (error) in
            switch error {
            case DecodingError.dataCorrupted(let context):

                XCTAssertEqual(context.debugDescription, "Key value header missing or corrupt.")

            default: XCTFail("Incorrect error returned: \(error)")
            }
        }
    }

    // MARK: UnkeyedContainer Tests

    func testUnkeyedContainerWithValidByteInput() throws {

        class ExpectedClass: Decodable {
            let a: Int32

            required init(from decoder: Decoder) throws {
                var container = try decoder.unkeyedContainer()

                self.a = try container.decode(Int32.self)
            }
        }

        let input: [UInt8] = [                     /// Header:
                              0xc,  0x0, 0x0, 0x0, /// - Container Type

                                                   /// UnkeyedValueContainer:
                              0x1,  0x0, 0x0, 0x0, /// - Count

                                                   /// Header:
                              0xd,  0x0, 0x0, 0x0, /// - Container Type

                                                   /// SingleValueContainer:
                              0xa5, 0x0, 0x0, 0x0, /// - Type
                              0x4,  0x0, 0x0, 0x0, /// - Size
                              0xa,  0x0, 0x0, 0x0  /// - Value
            ]

        XCTAssertEqual(try decoder.decode(ExpectedClass.self, from: input).a, 10)
    }

    func testUnkeyedContainerWithValueMissingContainer() throws {

        let input: [UInt8] = [                     /// Header:
                              0xc,  0x0, 0x0, 0x0, /// - Container Type

                                                   /// UnkeyedValueContainer:
                              0x1,  0x0, 0x0, 0x0, /// - Count

                                                   /// Header:
                              0xd,  0x0, 0x0, 0x0, /// - Container Type
            ]

        XCTAssertThrowsError(try decoder.decode(Int32.self, from: input)) { (error) in
            switch error {
            case DecodingError.dataCorrupted(let context):

                XCTAssertEqual(context.debugDescription, "Single value container header missing or corrupt.")

            default: XCTFail("Incorrect error returned: \(error)")
            }
        }
    }

}
