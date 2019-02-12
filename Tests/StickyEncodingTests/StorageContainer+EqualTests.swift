///
///  StorageContainerEqualTests.swift
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
///  Created by Tony Stone on 11/8/17.
///
import XCTest

@testable import StickyEncoding

class StorageContainerEqualTests: XCTestCase {

    func testEqualWithNullStorageContainer() {
        let input = NullStorageContainer.null
        let expected = NullStorageContainer.null

        XCTAssert(input.equal(expected), "\(expected) does not equal \(input)")
    }

    func testNotEqualWithNullStorageContainer() {
        let input = NullStorageContainer.null
        let expected = UnkeyedStorageContainer()

        XCTAssert(!input.equal(expected), "\(expected) equals \(input) but should not.")
    }

    func testEqualWithKeyedStorageContainer() {
        let input = KeyedStorageContainer()
        let expected = KeyedStorageContainer()

        XCTAssert(input.equal(expected), "\(expected) does not equal \(input)")
    }

    func testNotEqualWithKeyedStorageContainer() {
        let input = KeyedStorageContainer()
        let expected = UnkeyedStorageContainer()

        XCTAssert(!input.equal(expected), "\(expected) equals \(input) but should not.")
    }

    func testEqualWithUnkeyedStorageContainer() {
        let input = UnkeyedStorageContainer()
        let expected = UnkeyedStorageContainer()

        XCTAssert(input.equal(expected), "\(expected) does not equal \(input)")
    }

    func testNotEqualWithUnkeyedtorageContainer() {
        let input = UnkeyedStorageContainer()
        let expected = KeyedStorageContainer()

        XCTAssert(!input.equal(expected), "\(expected) equals \(input) but should not.")
    }

    func testEqualWithSingleValueContainer() {
        let input = SingleValueContainer("Test String")
        let expected = SingleValueContainer("Test String")

        XCTAssert(input.equal(expected), "\(expected) does not equal \(input)")
    }

    func testNotEqualWithSingleValueContainer() {
        let input = SingleValueContainer("Test String")
        let expected = SingleValueContainer(32)

        XCTAssert(!input.equal(expected), "\(expected) equals \(input) but should not.")
    }

    func testEqualWithUnkeyedStorageContainerAndNestedSingleValueeContainer() {
        let input: UnkeyedStorageContainer = {
            let container = UnkeyedStorageContainer()
            container.push(SingleValueContainer("Test String"))
            return container
        }()
        let expected: UnkeyedStorageContainer = {
            let container = UnkeyedStorageContainer()
            container.push(SingleValueContainer("Test String"))
            return container
        }()

        XCTAssert(input.equal(expected), "\(expected) does not equal \(input)")
    }

    func testNotEqualWithUnkeyedStorageContainerAndNestedSingleValueContainer() {
        let input: UnkeyedStorageContainer = {
            let container = UnkeyedStorageContainer()
            container.push(SingleValueContainer("Test String"))
            return container
        }()
        let expected: UnkeyedStorageContainer = {
            let container = UnkeyedStorageContainer()
            container.push(SingleValueContainer("Incorrect Test String"))
            return container
        }()

        XCTAssert(!input.equal(expected), "\(expected) equals \(input) but should not.")
    }

    func testEqualWithKeyedStorageContainerAndNestedSingleValueeContainer() {
        let input: KeyedStorageContainer = {
            let keyed = KeyedStorageContainer()
            let unkeyed = UnkeyedStorageContainer()
            unkeyed.push(SingleValueContainer("Test String"))
            keyed["key 1"] = unkeyed
            return keyed
        }()
        let expected: KeyedStorageContainer = {
            let keyed = KeyedStorageContainer()
            let unkeyed = UnkeyedStorageContainer()
            unkeyed.push(SingleValueContainer("Test String"))
            keyed["key 1"] = unkeyed
            return keyed
        }()

        XCTAssert(input.equal(expected), "\(expected) does not equal \(input)")
    }

    func testNotEqualWithKeyedStorageContainerAndNestedSingleValueContainer() {
        let input: KeyedStorageContainer = {
            let keyed = KeyedStorageContainer()
            let unkeyed = UnkeyedStorageContainer()
            unkeyed.push(SingleValueContainer("Test String"))
            keyed["key 1"] = unkeyed
            return keyed
        }()
        let expected: KeyedStorageContainer = {
            let keyed = KeyedStorageContainer()
            let unkeyed = UnkeyedStorageContainer()
            unkeyed.push(SingleValueContainer("Incorrect Test String"))
            keyed["key 1"] = unkeyed
            return keyed
        }()

        XCTAssert(!input.equal(expected), "\(expected) equals \(input) but should not.")
    }
}
