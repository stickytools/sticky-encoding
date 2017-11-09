///
///  KeyedStorageContainerTests.swift
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
/// Tests for the class `KeyedStorageContainer`.
///
class KeyedStorageContainerTests: XCTestCase {

    // MARK: - Init

    ///
    /// Test that the `init` func can be called.
    ///
    func testInit() {
        XCTAssertNotNil(KeyedStorageContainer())
    }

    // MARK: - Access

    ///
    /// Test that stored keys and values can be accessed through the `keys` var.
    ///
    func testKeys() {
        let input = KeyedStorageContainer()
        input["key1"] = ValueType(1)
        input["key2"] = ValueType(2)

        let result = input.keys

        XCTAssertTrue(result.contains("key1"))
        XCTAssertTrue(result.contains("key2"))
    }

    ///
    /// Test that the `contains` func returns the correct value.
    ///
    func testContains() {
        let input = KeyedStorageContainer()
        input["key1"] = ValueType(1)
        input["key2"] = ValueType(2)

        XCTAssertTrue(input.contains("key1"))
        XCTAssertTrue(input.contains("key2"))
    }

    ///
    /// Test the ability to access (get/set) elements via subscript.
    ///
    func testSubscript() {
        let input = KeyedStorageContainer()
        input["key1"] = ValueType(1)     /// Subscript set
        input["key2"] = ValueType(2)     /// Subscript set

        XCTAssertEqual(input["key1"] as? ValueType, ValueType(1))
        XCTAssertEqual(input["key2"] as? ValueType, ValueType(2))
    }

    // MARK: - CustomStringConvertible and CustomDebugStringConvertible conformance.

    ///
    /// Test that the `description` value is correct when empty.
    ///
    func testDescription() {
        XCTAssertEqual(KeyedStorageContainer().description, "[]")
    }

    ///
    /// Test that the `debugDescription` value is correct when empty.
    ///
    func testDebugDescription() {
        XCTAssertEqual(KeyedStorageContainer().debugDescription, "[]")
    }

    ///
    /// Test that the `description` value is correct when the container contains values.
    ///
    func testDescriptionWithValues() {
        let input = KeyedStorageContainer()
        input["key1"] = ValueType(1)
        input["key2"] = ValueType(2)

        let result = input.description

        /// Make sure the keys is present
        XCTAssertNotNil(result.range(of: ".*key1: Description 1.*", options: [.regularExpression]))
        XCTAssertNotNil(result.range(of: ".*key2: Description 2.*", options: [.regularExpression]))
        /// Now match the rest of the expected string
        XCTAssertNotNil(result.range(of: "^\\[key[12]: Description [12], key[12]: Description [12]\\]$", options: [.regularExpression, .anchored]))
    }

    ///
    /// Test that the `debugDescription` value is correct when the container contains values.
    ///
    func testDebugDescriptionWithValues() {
        let input = KeyedStorageContainer()
        input["key1"] = ValueType(1)
        input["key2"] = ValueType(2)

        let result = input.debugDescription

        /// Make sure the keys is present
        XCTAssertNotNil(result.range(of: ".*key1.: DebugDescription 1.*", options: [.regularExpression]))
        XCTAssertNotNil(result.range(of: ".*key2.: DebugDescription 2.*", options: [.regularExpression]))
        /// Now match the rest of the expected string
        XCTAssertNotNil(result.range(of: "^\\[\\\"key[12]\\\": DebugDescription [12], \\\"key[12]\\\": DebugDescription [12]\\]$", options: [.regularExpression, .anchored]))
    }
}

///
/// Tests for the inner class `ElementReference` of `KeyedStorageContainer`.
///
class KeyedStorageContainerElementReferenceTests: XCTestCase {

    ///
    /// Test that the `init` func can be called.
    ///
    func testInit() {
        XCTAssertNotNil(KeyedStorageContainer().elementReference(for: "key"))
    }

    ///
    /// Test that the `description` value is correct when empty.
    ///
    func testDescription() {
        XCTAssertEqual(String(describing: KeyedStorageContainer().elementReference(for: "key1")), "nil")
    }

    ///
    /// Test that the `debugDescription` value is correct when empty.
    ///
    func testDebugDescription() {
        XCTAssertEqual(String(reflecting: KeyedStorageContainer().elementReference(for: "key1")), "nil")
    }

    ///
    /// Test that the `description` value is correct when the reference contains a value.
    ///
    func testDescriptionWithValue() {
        let input = KeyedStorageContainer()
        input["key1"] = ValueType(1)

        XCTAssertEqual(String(describing: input.elementReference(for: "key1")), "Description 1")
    }

    ///
    /// Test that the `debugDescription` value is correct when the reference contains a value.
    ///
    func testDebugDescriptionWithValue() {
        let input = KeyedStorageContainer()
        input["key1"] = ValueType(1)

        XCTAssertEqual(String(reflecting: input.elementReference(for: "key1")), "DebugDescription 1")
    }
}

