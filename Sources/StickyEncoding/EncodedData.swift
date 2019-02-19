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
import Swift

///
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
///    FileManager.default.createFile(atPath: "employee.bin", contents: Data(bytes: encodedData.bytes))
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

    // MARK: - Reading encoded data

    /// Initializes `self` with a null value.
    ///
    public init() {
        self.storage = NullStorageContainer.null
    }

    /// Initializes `'self` using the data stored in `buffer`.
    ///
    public init(from buffer: UnsafeRawBufferPointer) {
        self.storage  = StorageContainerReader.read(from: buffer)
    }

    /// Initializes `'self` using the data stored in `bytes`.
    ///
    public init(bytes: [UInt8]) {
        self.storage = bytes.withUnsafeBytes { StorageContainerReader.read(from: $0) }
    }

    // MARK: - Writing encoded data

    ///
    /// Returns a byte array representing the stored value
    ///
    public lazy var bytes: [UInt8] = {
        var array: [UInt8] = Array<UInt8>(repeating: 0x0, count: self.byteCount)

        let _ = array.withUnsafeMutableBytes({ StorageContainerWriter.write(self.storage, to: $0) })
        return array
    }()

    ///
    /// Returns the count of bytes required to store the value in binary form.
    ///
    public lazy var byteCount: Int = {
        return StorageContainerWriter.byteCount(self.storage)
    }()

    ///
    /// Write the binary representation of the value to `buffer`.
    ///
    /// - Precondition: `buffer` must be `byteCount` size or larger.
    ///
    @discardableResult
    public func write(to buffer: UnsafeMutableRawBufferPointer) -> Int {
        return StorageContainerWriter.write(self.storage, to: buffer)
    }

    // MARK: - Internal storage and methods

    ///
    /// Initialize self with a `StorageContainer` type (intermediary form of binary encoded data).
    ///
    internal init(_ storage: StorageContainer) {
        self.storage = storage
    }

    ///
    /// All inputs convert to the intermediary form of `StorageContainer`.
    ///
    internal var storage: StorageContainer
}

