///
///  PassthroughReferenceTests.swift
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

class StorageContainerReferenceTests: XCTestCase {

    func testCanImplement() {
        class InputType: StorageContainerReference {
            var value: StorageContainer? = nil
        }
        XCTAssertNotNil(InputType())
    }
}

class PassthroughReferenceTests: XCTestCase {

    ///
    /// Test that the `init` func can be called.
    ///
    func testInit() {
        let input = PassthroughReference()

        XCTAssertNotNil(input)
        XCTAssert(input.value == nil)
    }

    ///
    /// Test that the `init` func can be called with a value.
    ///
    func testInitWithValue() {
        class InputType: StorageContainer {}

        let expected = InputType()
        let input = PassthroughReference(expected)

        XCTAssertNotNil(input)
        guard let inputType = input.value as? InputType
            else { XCTFail("Incorrect type returned"); return }

        XCTAssert(inputType === expected)
    }

    ///
    /// Test that the `description` value is correct when empty.
    ///
    func testDescription() {
        XCTAssertEqual(PassthroughReference().description, "nil")
    }

    ///
    /// Test that the `debugDescription` value is correct when empty.
    ///
    func testDebugDescription() {
        XCTAssertEqual(PassthroughReference().debugDescription, "nil")
    }

    ///
    /// Test that the `description` value is correct when the reference contains values.
    ///
    func testDescriptionWithWrappedValue() {
        class InputType: StorageContainer, CustomStringConvertible {
            var description: String { return "InputType()" }
        }
        XCTAssertEqual(PassthroughReference(InputType()).description, "InputType()")
    }

    ///
    /// Test that the `debugDescription` value is correct when the reference contains values.
    ///
    func testDebugDescriptionWithWrappedValue() {
        class InputType: StorageContainer, CustomDebugStringConvertible {
            var debugDescription: String { return "InputType()" }
        }
        XCTAssertEqual(PassthroughReference(InputType()).debugDescription, "InputType()")
    }
}
