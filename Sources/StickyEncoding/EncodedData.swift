///
///  EncodedData.swift
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
import Foundation

/// An intermediate representation which represents the encoded data.  This type is the direct connection between
/// raw memory and a type that can be converted to and from an `Codable` object.
///
/// StickyEncoding uses an intermediate representation so that it can support many use cases from
/// direct byte conversion to writing/reading directly to/from raw memory.
///
/// When encoding of an object, the intermediate representation has already been
/// encoded down to a form that can be rapidly written to memory.
/// ```
///    let encodedData = try encoder.encode(employee)
///
///    // Write the bytes directly to a file.
///    FileManager.default.createFile(atPath: "employee.bin", contents: Data(encodedData))
/// ```
/// There are use cases that require writing to a buffer or socket in which case StickyEncoding offers a direct write method so that an intermediate structure (byte array) does not have to be created first.
/// ```
///    let encodedData = try encoder.encode(employee)
///
///    // Allocate byte aligned raw memory to hold the binary encoded data.
///    let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: encodedData.byteCount, alignment: MemoryLayout<UInt8>.alignment)
///
///    // Write the encoded data directly to the raw memory.
///    encodedData.write(to: buffer)
/// ```
///
public class EncodedData {

    /// Initializes `self` with a null value.
    ///
    public init() {
        self.storage = NullStorageContainer.null
    }

    /// Returns the count of bytes required to store the value in binary form.
    ///
    public lazy var byteCount: Int = {
        return StorageContainerWriter.byteCount(self.storage)
    }()

    /// Initialize self with a `StorageContainer` type (intermediary form of binary encoded data).
    ///
    internal init(_ storage: StorageContainer) {
        self.storage = storage
    }

    /// All inputs convert to the intermediary form of `StorageContainer`.
    ///
    internal let storage: StorageContainer
}

/// Support to/from UnsafeRawBuffers.
///
public extension EncodedData {

    /// Initializes `'self` using the data stored in `buffer`.
    ///
    public convenience init(from buffer: UnsafeRawBufferPointer) {
        self.init(StorageContainerReader.read(from: buffer))
    }

    /// Write the binary representation of the value to `buffer`.
    ///
    /// - Parameter buffer: The `UnsafeMutableRawBufferPointer` instance used to construct the instance from.
    ///
    /// - Precondition: `buffer` must be `byteCount` size or larger.
    ///
    @discardableResult
    public func write(to buffer: UnsafeMutableRawBufferPointer) -> Int {
        return StorageContainerWriter.write(self.storage, to: buffer)
    }
}

/// Support to/from Array<UInt8>
///
public extension Array where Element == UInt8 {

    /// Constructs an Array from an EncodedData instance.
    ///
    /// - Parameter encodedData: The `EncodedData` instance used to construct the instance from.
    ///
    init(_ encodedData: EncodedData) {
        self.init(repeating: 0x0, count: encodedData.byteCount)

        _ = self.withUnsafeMutableBytes({ StorageContainerWriter.write(encodedData.storage, to: $0) })
    }
}

public extension EncodedData {

    /// Constructs an `EncodedData` instance from an Array<UInt8>.
    ///
    /// - Parameter bytes: The `Array<UInt8>` instance used to construct the instance from.
    ///
    public convenience init(_ bytes: [UInt8]) {
        self.init(bytes.withUnsafeBytes { StorageContainerReader.read(from: $0) })
    }
}

/// Support to/from Data.
///
public extension Data {

    /// Create a `Data` instance from an `EncodedData` instance.
    ///
    /// - Parameter encodedData: The `EncodedData` instance used to construct the instance from.
    ///
    init(_ encodedData: EncodedData) {
        self.init(count: encodedData.byteCount)

        /// Get the correct type of pointer to Data's internal storage
        self.withUnsafeMutableBytes { (pointer: UnsafeMutablePointer<UInt8>) -> Void in
            let buffer = UnsafeMutableRawBufferPointer(start: pointer, count: encodedData.byteCount)

            /// Write the encoded data directly to the internal storage.
            encodedData.write(to: buffer)
        }
    }
}

public extension EncodedData {

    /// Constructs an `EncodedData` from an `Data` instance.
    ///
    /// - Parameter data: The `Data` instance used to construct the instance from.
    ///
    public convenience init(_ data: Data) {

        self.init(data.withUnsafeBytes({ (pointer: UnsafePointer<UInt8>) -> StorageContainer in
            let buffer = UnsafeRawBufferPointer(start: pointer, count: data.count)
            return StorageContainerReader.read(from: buffer)
        }))
    }
}
