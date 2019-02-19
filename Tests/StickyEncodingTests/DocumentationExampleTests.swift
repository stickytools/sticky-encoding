///
///  DocumentationExampleTests.swift
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
///  Created by Tony Stone on 2/13/19.
///
import XCTest

import StickyEncoding

class DocumentationExampleTests: XCTestCase {

    let encoder = BinaryEncoder()
    let decoder = BinaryDecoder()

    /// Documentation Examples
    ///
    /// These test should represent the documentations examples exactly
    /// with no XCTAsserts added.  These tests are to make sure that the
    /// examples compile and run.
    ///

    func testBinaryEncoderExample1() throws {

        let string = "You can encode single values of any type."

        let encoded = try encoder.encode(string)
    }

    func testBinaryEncoderExample2() throws {

        /// Actual code in example.
        ///
        struct Employee: Codable {
            let first: String
            let last: String
            let employeeNumber: Int
        }

        let employee = Employee(first: "John", last: "Doe", employeeNumber: 2345643)

        let encodedData = try encoder.encode(employee)
    }

    func testBinaryDecoderExample1() throws {

        struct Employee: Codable {
            let first: String
            let last: String
            let employeeNumber: Int
        }

        let encodedData = try encoder.encode(Employee(first: "John", last: "Doe", employeeNumber: 2345643))

        /// Actual code in example.
        ///
        let employee = try decoder.decode(Employee.self, from: encodedData)
    }

    func testEncodedDataExample1() throws {

        /// Code from previous example used as boiler plate for this example.
        ///
        struct Employee: Codable {
            let first: String
            let last: String
            let employeeNumber: Int
        }

        let employee = Employee(first: "John", last: "Doe", employeeNumber: 2345643)

        /// Actual code in example.
        ///
        let encodedData = try encoder.encode(employee)

        FileManager.default.createFile(atPath: "employee.bin", contents: Data(bytes: encodedData.bytes))
    }

    func testEncodedDataExample2() throws {

        /// Code from previous example used as boiler plate for this example.
        ///
        struct Employee: Codable {
            let first: String
            let last: String
            let employeeNumber: Int
        }

        let employee = Employee(first: "John", last: "Doe", employeeNumber: 2345643)

        /// Actual code in example.
        ///
        let encodedData = try encoder.encode(employee)

        let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: encodedData.byteCount, alignment: MemoryLayout<UInt8>.alignment)

        encodedData.write(to: buffer)
    }
}
