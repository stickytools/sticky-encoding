///
///  DecodingError+ExtensionsTests.swift
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
/// Created by Tony Stone on 11/2/17.
///
import XCTest

@testable import StickyEncoding

class DecodingError_ExtensionsTests: XCTestCase {

    enum CodingKeys: CodingKey { case testVar1, testVar2 }

    // MARK: - `keyNotFound` tests.

    func testKeyNotFoundError() {
        let error = DecodingError.keyNotFoundError(at: [CodingKeys.testVar1], forKey: CodingKeys.testVar2)

        switch error {
        case .keyNotFound(let key, let context):

            XCTAssertEqual(key.stringValue, CodingKeys.testVar2.stringValue)
            XCTAssertTrue(context.codingPath.elementsEqual([CodingKeys.testVar1], by: { $0.stringValue == $1.stringValue }))
            XCTAssertEqual(context.debugDescription, "No value associated with key \"testVar2\".")
        default:
            XCTFail("Incorrect error returned: \(error)")
        }
    }

    // MARK: - `typeMismatchError` tests.

    func testTypeMismatchErrorForActuaTypeNullStorageContainer() {
        let error = DecodingError.typeMismatchError(at: [CodingKeys.testVar1], expected: Bool.self, actual: NullStorageContainer.null)

        switch error {
        case .typeMismatch(let type, let context):

            XCTAssertTrue(type == Bool.self)
            XCTAssertTrue(context.codingPath.elementsEqual([CodingKeys.testVar1], by: { $0.stringValue == $1.stringValue }))
            XCTAssertEqual(context.debugDescription, "Expected to decode Bool but found a null value instead.")
        default:
            XCTFail("Incorrect error returned: \(error)")
        }
    }

    func testTypeMismatchErrorForActuaTypeKeyedStorageContainer() {
        let error = DecodingError.typeMismatchError(at: [CodingKeys.testVar1], expected: Bool.self, actual: KeyedStorageContainer())

        switch error {
        case .typeMismatch(let type, let context):

            XCTAssertTrue(type == Bool.self)
            XCTAssertTrue(context.codingPath.elementsEqual([CodingKeys.testVar1], by: { $0.stringValue == $1.stringValue }))
            XCTAssertEqual(context.debugDescription, "Expected to decode Bool but found KeyedDecodingContainer<CodingKeys> instead.")
        default:
            XCTFail("Incorrect error returned: \(error)")
        }
    }

    func testTypeMismatchErrorForActuaTypeUnkeyedStorageContainer() {
        let error = DecodingError.typeMismatchError(at: [CodingKeys.testVar1], expected: Bool.self, actual: UnkeyedStorageContainer())

        switch error {
        case .typeMismatch(let type, let context):

            XCTAssertTrue(type == Bool.self)
            XCTAssertTrue(context.codingPath.elementsEqual([CodingKeys.testVar1], by: { $0.stringValue == $1.stringValue }))
            XCTAssertEqual(context.debugDescription, "Expected to decode Bool but found UnkeyedDecodingContainer instead.")
        default:
            XCTFail("Incorrect error returned: \(error)")
        }
    }

    func testTypeMismatchErrorForActuaTypeSingleValueContainer() {
        let error = DecodingError.typeMismatchError(at: [CodingKeys.testVar1], expected: Bool.self, actual: SingleValueContainer(32))

        switch error {
        case .typeMismatch(let type, let context):

            XCTAssertTrue(type == Bool.self)
            XCTAssertTrue(context.codingPath.elementsEqual([CodingKeys.testVar1], by: { $0.stringValue == $1.stringValue }))
            XCTAssertEqual(context.debugDescription, "Expected to decode Bool but found SingleValueDecodingContainer instead.")
        default:
            XCTFail("Incorrect error returned: \(error)")
        }
    }

    func testTypeMismatchErrorForActuaTypeInt() {
        let error = DecodingError.typeMismatchError(at: [CodingKeys.testVar1], expected: Bool.self, actual: Int(1))

        switch error {
        case .typeMismatch(let type, let context):

            XCTAssertTrue(type == Bool.self)
            XCTAssertTrue(context.codingPath.elementsEqual([CodingKeys.testVar1], by: { $0.stringValue == $1.stringValue }))
            XCTAssertEqual(context.debugDescription, "Expected to decode Bool but found Int instead.")
        default:
            XCTFail("Incorrect error returned: \(error)")
        }
    }

    func testTypeMismatchErrorForActuaTypeEncodedInt() {
        let error = DecodingError.typeMismatchError(at: [CodingKeys.testVar1], expected: Bool.self, actual: EncodedType.int)

        switch error {
        case .typeMismatch(let type, let context):

            XCTAssertTrue(type == Bool.self)
            XCTAssertTrue(context.codingPath.elementsEqual([CodingKeys.testVar1], by: { $0.stringValue == $1.stringValue }))
            XCTAssertEqual(context.debugDescription, "Expected to decode Bool but found Int instead.")
        default:
            XCTFail("Incorrect error returned: \(error)")
        }
    }

    // MARK: - `valueNotFound` tests.

    func testValueNotFound() {
        let error = DecodingError.valueNotFoundError(at: [CodingKeys.testVar1], expected: Bool.self)

        switch error {
        case .valueNotFound(let type, let context):

            XCTAssertTrue(type == Bool.self)
            XCTAssertTrue(context.codingPath.elementsEqual([CodingKeys.testVar1], by: { $0.stringValue == $1.stringValue }))
            XCTAssertEqual(context.debugDescription, "Expected Bool value but found null instead.")
        default:
            XCTFail("Incorrect error returned: \(error)")
        }
    }

    func testValueNotFoundIsAtEnd() {
        let error = DecodingError.valueNotFoundError(at: [CodingKeys.testVar1], expected: Bool.self, isAtEnd: true)

        switch error {
        case .valueNotFound(let type, let context):

            XCTAssertTrue(type == Bool.self)
            XCTAssertTrue(context.codingPath.elementsEqual([CodingKeys.testVar1], by: { $0.stringValue == $1.stringValue }))
            XCTAssertEqual(context.debugDescription, "Unkeyed container is at end.")
        default:
            XCTFail("Incorrect error returned: \(error)")
        }
    }
}
