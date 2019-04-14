///
///  BinaryEncoder+ByteArrayTests.swift
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

class BinaryEncoderByteArrayTests: XCTestCase {

    let encoder = BinaryEncoder()

    // MARK: SingleValueContainer Tests

    func testSingleValueContainer() throws {

        let input             = Int32(10)
        let expected: [UInt8] = [0xd,  0x0, 0x0, 0x0, /// Header: Container Type
                                 0xc,  0x0, 0x0, 0x0, /// Header: Byte count
                                 0xa5, 0x0, 0x0, 0x0, /// SingleValueContainer: Type
                                 0x4,  0x0, 0x0, 0x0, /// SingleValueContainer: Size
                                 0xa,  0x0, 0x0, 0x0  /// SingleValueContainer: Value
        ]

        XCTAssertEqual(try encoder.encode(input), expected)
    }

    // MARK: KeyedContainer Tests

    func testKeyedContainer() throws {

        struct InputType: Encodable {
            let a: Int32
        }

        let input             = InputType(a: 10)
        let expected: [UInt8] = [                     /// Header:
                                 0xb,  0x0, 0x0, 0x0, /// - Container Type
                                 0x28, 0x0, 0x0, 0x0, /// - Byte count

                                                      /// KeyedValueContainer:
                                 0x1,  0x0, 0x0, 0x0, /// - Count
                                 0x0,  0x0, 0x0, 0x0, /// - Alignment Padding

                                                      /// key:
                                 0x1,  0x0, 0x0, 0x0, /// - Size
                                 0x61, 0x0, 0x0, 0x0, /// - Value + Alignment Padding

                                                      /// Header:
                                 0xd,  0x0, 0x0, 0x0, /// - Container Type
                                 0xc,  0x0, 0x0, 0x0, /// - Byte count

                                                     /// SingleValueContainer:
                                 0xa5, 0x0, 0x0, 0x0, /// - Type
                                 0x4,  0x0, 0x0, 0x0, /// - Size
                                 0xa,  0x0, 0x0, 0x0, /// - Value
                                 0x0,  0x0, 0x0, 0x0  /// - Alignment Padding
        ]

        XCTAssertEqual(try encoder.encode(input), expected)
    }

    // MARK: UnkeyedContainer Tests

    func testUnkeyedContainerWithValidByteInput() throws {

        struct InputType: Encodable {
            let a: Int32

            func encode(to encoder: Encoder) throws {
                var container = encoder.unkeyedContainer()

                try container.encode(a)
            }
        }

        let input             = InputType(a: 10)
        let expected: [UInt8] = [                     /// Header:
                                 0xc,  0x0, 0x0, 0x0, /// - Container Type
                                 0x20, 0x0, 0x0, 0x0, /// - Byte count

                                                      /// UnkeyedValueContainer:
                                 0x1,  0x0, 0x0, 0x0, /// - Count
                                 0x0,  0x0, 0x0, 0x0, /// - Alignment Padding

                                                      /// Header:
                                 0xd,  0x0, 0x0, 0x0, /// - Container Type
                                 0xc,  0x0, 0x0, 0x0, /// - Byte count

                                                      /// SingleValueContainer:
                                 0xa5, 0x0, 0x0, 0x0, /// - Type
                                 0x4,  0x0, 0x0, 0x0, /// - Size
                                 0xa,  0x0, 0x0, 0x0, /// - Value
                                 0x0,  0x0, 0x0, 0x0  /// - Alignment Padding
        ]

        XCTAssertEqual(try encoder.encode(input), expected)
    }

    // MARK: NullContainer Tests

    func testNullContainerWithZeroLengthByteCount() throws {

        let input: Optional<Int32> = nil
        let expected: [UInt8] = [0xa,  0x0, 0x0, 0x0, /// Header: Container Type
                                 0x0,  0x0, 0x0, 0x0  /// Header: Byte count
        ]

        XCTAssertEqual(try encoder.encode(input), expected)
    }
}
