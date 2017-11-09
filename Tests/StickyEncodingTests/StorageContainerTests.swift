///
///  StorageContainerTests.swift
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
/// Tests for the `StorageContainer` protocol type.
///
class StorageContainerTests: XCTestCase {

    func testCanImplement() {
        class InputType: StorageContainer {}

        XCTAssertNotNil(InputType())
    }
}

///
/// Tests for the `NullStorageContainer` type.
///
class NullStorageContainerTests: XCTestCase {

    ///
    /// Test that the singleton method `null` returns the correct type value.
    ///
    func testNull() {
        XCTAssertTrue(type(of: NullStorageContainer.null) == NullStorageContainer.self)
    }

    ///
    /// Test that the singleton method `null` returns the same object each time.
    ///
    func testNullIsTheSameObject() {
        let null1 = NullStorageContainer.null
        let null2 = NullStorageContainer.null

        XCTAssertTrue(null1 === null2)
    }

    ///
    /// Test that the `description` value is correct.
    ///
    func testDescription() {
        XCTAssertEqual(NullStorageContainer.null.description, "null")
    }

    ///
    /// Test that the `debugDescription` value is correct.
    ///
    func testDebugDescription() {
        XCTAssertEqual(NullStorageContainer.null.debugDescription, "null")
    }
}
