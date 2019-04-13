///
///  EncodedDataTests.swift
///
///  Copyright 2017 Tony Stone
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
///  Created by Tony Stone on 11/7/17.
///
import XCTest

@testable import StickyEncoding

class EncodedDataTests: XCTestCase {

    // MARK: - `Array` Tests

    func testArrayFullRoundTripOfBasicStruct() throws {

        let input    = BasicStruct(boolVar: true, intVar: 123, doubleVar: 123.23, stringVar: "Test String")
        let expected = input

        let encoder = BinaryEncoder()
        let decoder = BinaryDecoder()

        let array = Array(try encoder.encode(input))
        let result = try decoder.decode(BasicStruct.self, from: array)

        XCTAssertEqual(result, expected)
    }

    // MARK: - `Data` Tests

    func testDataFullRoundTripOfBasicStruct() throws {

        let input    = BasicStruct(boolVar: true, intVar: 123, doubleVar: 123.23, stringVar: "Test String")
        let expected = input

        let encoder = BinaryEncoder()
        let decoder = BinaryDecoder()

        let data = Data(try encoder.encode(input))
        let result = try decoder.decode(BasicStruct.self, from: Array(data))

        XCTAssertEqual(result, expected)
    }
}
