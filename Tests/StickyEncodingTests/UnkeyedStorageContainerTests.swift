///
///  UnkeyedStorageContainerTests.swift
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
///  Created by Tony Stone on 10/23/17.
///
import XCTest

@testable import StickyEncoding

///
/// Class used for testing functionality in this test file.
///
private class ValueType: StorageContainer, Equatable, CustomStringConvertible, CustomDebugStringConvertible {
    let value: Int
    init(_ value: Int) { self.value = value }

    static func == (lhs: ValueType, rhs: ValueType) -> Bool {
        return lhs.value == rhs.value
    }
    var description: String { return "Description \(value)" }
    var debugDescription: String { return "DebugDescription \(value)" }
}

///
/// Tests for the class `UnkeyedStorageContainer`.
///
class UnkeyedStorageContainerTests: XCTestCase {

    // MARK: - Init

    ///
    /// Test that the `init` func can be called.
    ///
    func testInit() {
        XCTAssertNotNil(UnkeyedStorageContainer())
    }

    // MARK: Access

    ///
    /// Test that the `push` func stores the values correctly.
    ///
    func testPush() {
        let input = UnkeyedStorageContainer()
        input.push(ValueType(1))
        input.push(ValueType(2))

        XCTAssertEqual(input[0] as? ValueType, ValueType(1))
        XCTAssertEqual(input[1] as? ValueType, ValueType(2))
    }

    ///
    /// Test the ability to access (get/set) elements via subscript.
    ///
    func testSubscript() {
        let input = UnkeyedStorageContainer()

        // Push 2 values to extend the structure
        input.push(ValueType(1))
        input.push(ValueType(2))

        // replace the values through the subscripts
        input[0] = ValueType(3)
        input[1] = ValueType(4)

        XCTAssertEqual(input[0] as? ValueType, ValueType(3))
        XCTAssertEqual(input[1] as? ValueType, ValueType(4))
    }

    // MARK: - CustomStringConvertible and CustomDebugStringConvertible conformance

    ///
    /// Test that the `description` value is correct when empty.
    ///
    func testDescription() {
        XCTAssertEqual(UnkeyedStorageContainer().description, "[]")
    }

    ///
    /// Test that the `debugDescription` value is correct when empty.
    ///
    func testDebugDescription() {
        XCTAssertEqual(UnkeyedStorageContainer().debugDescription, "[]")
    }

    ///
    /// Test that the `description` value is correct when the container contains values.
    ///
    func testDescriptionWithValues() {
        let input = UnkeyedStorageContainer()
        input.push(ValueType(1))
        input.push(ValueType(2))

        XCTAssertEqual(input.description, "[Description 1, Description 2]")
    }

    ///
    /// Test that the `debugDescription` value is correct when the container contains values.
    ///
    func testDebugDescriptionWithValues() {
        let input = UnkeyedStorageContainer()
        input.push(ValueType(1))
        input.push(ValueType(2))

        XCTAssertEqual(input.debugDescription, "[DebugDescription 1, DebugDescription 2]")
    }
}

///
/// Tests for the inner class `ElementReference` of `UnkeyedStorageContainer`.
///
class UnkeyedStorageContainerElementReferenceTests: XCTestCase {

    // MARK: - Init

    ///
    /// Test that the `init` func can be called.
    ///
    func testInit() {
        XCTAssertNotNil(UnkeyedStorageContainer().pushReference())
    }

    // MARK: Access

    ///
    /// Test the ability to access get the value via the `value` var.
    ///
    func testValueGet() {
        let input = UnkeyedStorageContainer().pushReference()

        XCTAssertEqual(input.value as? NullStorageContainer, NullStorageContainer.null)
    }

    ///
    /// Test the ability to access set the value via the `value` var.
    ///
    func testValueSet() {
        let input = UnkeyedStorageContainer().pushReference()
        input.value = ValueType(1)

        XCTAssertEqual(input.value as? ValueType, ValueType(1))
    }

    // MARK: - CustomStringConvertible and CustomDebugStringConvertible conformance

    ///
    /// Test that the `description` value is correct when empty.
    ///
    func testDescription() {
        XCTAssertEqual(String(describing: UnkeyedStorageContainer().pushReference()), "null")
    }

    ///
    /// Test that the `debugDescription` value is correct when empty.
    ///
    func testDebugDescription() {
        XCTAssertEqual(String(reflecting: UnkeyedStorageContainer().pushReference()), "null")
    }

    ///
    /// Test that the `description` value is correct when the reference contains a value.
    ///
    func testDescriptionWithValue() {
        let input = UnkeyedStorageContainer()
        let reference = input.pushReference()
        reference.value = ValueType(1)

        XCTAssertEqual(String(describing: reference), "Description 1")
    }

    ///
    /// Test that the `debugDescription` value is correct when the reference contains a value.
    ///
    func testDebugDescriptionWithValue() {
        let input = UnkeyedStorageContainer()
        let reference = input.pushReference()
        reference.value = ValueType(1)

        XCTAssertEqual(String(reflecting: reference), "DebugDescription 1")
    }
}
