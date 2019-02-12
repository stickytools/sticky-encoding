///
///  StorageContainerReaderWriterTests.swift
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
///  Created by Tony Stone on 11/05/17.
///
import XCTest

@testable import StickyEncoding

class StorageContainerReaderWriterTests: XCTestCase {

    // MARK: - `NullStorageContainer` tests.

    func testReadWriteRoundTripForNullStorageContainer() throws {

        let input    = NullStorageContainer.null
        let expected = NullStorageContainer.null

        let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: StorageContainerWriter.byteCount(input), alignment: MemoryLayout<UInt8>.alignment)
        defer { buffer.deallocate() }

        StorageContainerWriter.write(input, to: buffer)

        let result = StorageContainerReader.read(from: UnsafeRawBufferPointer(buffer))

        XCTAssert(result.equal(expected), "\(expected) does not equal \(input)")
    }

    // MARK: - `SingleValueContainer` tests.

    func testReadWriteRoundTripForSingleValueContainer() throws {

        let input    = SingleValueContainer("Test String")
        let expected = SingleValueContainer("Test String")

        let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: StorageContainerWriter.byteCount(input), alignment: MemoryLayout<UInt8>.alignment)
        defer { buffer.deallocate() }

        StorageContainerWriter.write(input, to: buffer)

        let result = StorageContainerReader.read(from: UnsafeRawBufferPointer(buffer))

        XCTAssert(result.equal(expected), "\(expected) does not equal \(input)")
    }

    // MARK: - `UnkeyedContainer` tests.

    func testReadWriteRoundTripForUnkeyedContainer() throws {

        var input: UnkeyedStorageContainer = {
            var container = UnkeyedStorageContainer()
            for i in 0..<5 {
                container.push(SingleValueContainer("Test String \(i)"))
            }
            return container
        }()
        let expected = input

        let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: StorageContainerWriter.byteCount(input), alignment: MemoryLayout<UInt8>.alignment)
        defer { buffer.deallocate() }

        StorageContainerWriter.write(input, to: buffer)

        let result = StorageContainerReader.read(from: UnsafeRawBufferPointer(buffer))

        XCTAssert(result.equal(expected), "\(expected) does not equal \(input)")
    }

    func testReadWriteRoundTripForUnkeyedContainerWithMixedSingleValueAndNull() throws {

        var input: UnkeyedStorageContainer = {
            var container = UnkeyedStorageContainer()
            container.push(SingleValueContainer("Test String 0"))
            container.push(NullStorageContainer.null)
            container.push(SingleValueContainer("Test String 1"))
            container.push(NullStorageContainer.null)
            return container
        }()
        let expected = input

        let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: StorageContainerWriter.byteCount(input), alignment: MemoryLayout<UInt8>.alignment)
        defer { buffer.deallocate() }

        StorageContainerWriter.write(input, to: buffer)

        let result = StorageContainerReader.read(from: UnsafeRawBufferPointer(buffer))

        XCTAssert(result.equal(expected), "\(expected) does not equal \(input)")
    }

    func testReadWriteRoundTripForUnkeyedContainerWithNestedUnkeyedContainers() throws {

        var input: UnkeyedStorageContainer = {
            var container = UnkeyedStorageContainer()
            container.push(UnkeyedStorageContainer())
            container.push(UnkeyedStorageContainer())
            return container
        }()
        let expected = input

        let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: StorageContainerWriter.byteCount(input), alignment: MemoryLayout<UInt8>.alignment)
        defer { buffer.deallocate() }

        StorageContainerWriter.write(input, to: buffer)

        let result = StorageContainerReader.read(from: UnsafeRawBufferPointer(buffer))

        XCTAssert(result.equal(expected), "\(expected) does not equal \(input)")
    }

    // MARK: - `KeyedStorageContainer` tests.

    func testReadWriteRoundTripForKeyedContainer() throws {

        var input: KeyedStorageContainer = {
            var container = KeyedStorageContainer()
            for i in 0..<5 {
                container["key \(i)"] = SingleValueContainer("Test String \(i)")
            }
            return container
        }()
        let expected = input

        let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: StorageContainerWriter.byteCount(input), alignment: MemoryLayout<UInt8>.alignment)
        defer { buffer.deallocate() }

        StorageContainerWriter.write(input, to: buffer)

        let result = StorageContainerReader.read(from: UnsafeRawBufferPointer(buffer))

        XCTAssert(result.equal(expected), "\(expected) does not equal \(input)")
    }
}
