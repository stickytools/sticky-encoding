///
///  StorageContainerReaderWriter.swift
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
///  Created by Tony Stone on 11/5/17.
///
///
import Swift

private enum Error: Swift.Error {
    case valueCorrupt(Any.Type, String)
}

///
/// The internal format of the binary representation consists
/// of the Header type, Element Header, and Element itself.
///
/// Since we read sequentially, there is no need for a random access structure.  We structure the data as
/// a sequential list of Element Header/Element with the header indicating the length of its element.  This
/// implies that you must read each element in turn in order to figure out where the next element is.
///
/// ```
///     |----------|----------|-----------|
///     |  Element |  Element |   Element |  ...
///     |----------|----------|-----------|
///
/// ```
///
private enum Element {

    struct ContainerType: Equatable {
        static let null          = ContainerType(0xa)
        static let keyed         = ContainerType(0xb)
        static let unkeyed       = ContainerType(0xc)
        static let singleValue   = ContainerType(0xd)

        static func == (lhs: ContainerType, rhs: ContainerType) -> Bool {
            return lhs.value == rhs.value
        }
        private init(_ value: Int) {
            self.value = Int32(value)
        }
        private let value: Int32
    }

    ///
    /// Element Header structure (will be written at the beginning of each Element)
    ///
    struct Header {
        init(_ type: ContainerType) {
            self.type     = type
        }
        let type: ContainerType
    }
}

///
/// Writes StorageContainers to binary storage.
///
internal class StorageContainerWriter {

    // MARK: - Root level methods

    @inline(__always)
    static func convert(_ storageContainer: StorageContainer) -> [UInt8] {
        var bytes = Array<UInt8>()

        self.write(storageContainer: storageContainer, to: &bytes)

        return bytes
    }

    // MARK: - Private methods

    private static func pad<T>(_ buffer: inout [UInt8], for type: T.Type) {
        let alignedOffset = align(offset: buffer.count, to: type)

        if alignedOffset > buffer.count {
            buffer.append(contentsOf: Array<UInt8>(repeating: 0x0, count: alignedOffset - buffer.count))
        }
    }

    private static func write(header type: Element.ContainerType, to buffer: inout [UInt8]) {

        /// Align Header if required
        pad(&buffer, for: Element.Header.self)

        withUnsafeBytes(of: Element.Header(type)) {  buffer.append(contentsOf: $0) }
    }

    /// Write a container as an Element (Header + Container).
    ///
    /// ```
    ///     |---------|------------|
    ///     | Header  |  Container |
    ///     |---------|------------|
    /// ```
    ///
    /* Do not inline, recursively called */
    private static func write(storageContainer: StorageContainer, to buffer: inout [UInt8]) {

        /// Write -> Data
        switch storageContainer {

        case let container as SingleValueContainer:    write(singleValue: container, to: &buffer); break
        case let container as UnkeyedStorageContainer: write(unkeyed:     container, to: &buffer); break
        case let container as KeyedStorageContainer:   write(keyed:       container, to: &buffer); break
        case is NullStorageContainer: fallthrough
        default:
            write(null: NullStorageContainer.null, to: &buffer); break
        }
    }

    // MARK: - `SingleValueContainer` methods.

    /// Writes a single value container to the buffer.
    ///
    /// The format is determed by the container iself since,
    /// in the case of the SingleValueContainer, it is already
    /// in byte form.
    /// ```
    ///     |-------|------|---------/ /--------|
    ///     | type  | size |       value        |
    ///     |-------|------|--------/ /---------|
    ///
    ///       Int32 | In32 | Determined by size
    /// ```
    @inline(__always)
    private static func write(singleValue storageContainer: SingleValueContainer, to buffer: inout [UInt8]) {

        /// Write the header
        write(header: .singleValue, to: &buffer)

        buffer.append(contentsOf: storageContainer.bytes)
    }

    // MARK: - `UnkeyedStorageContainer` methods.

    ///
    /// Writes an `UnkeyedStorageContainer` to `buffer` and returns the number of bytes written.
    ///
    /// ```
    ///     |----------|-----------|-----------|-----------|
    ///     |  count   | Element 0 | Element 1 | Element n |
    ///     |----------|-----------|-----------|-----------|
    ///         Int32
    /// ```
    ///
    @inline(__always)
    private static func write(unkeyed storageContainer: UnkeyedStorageContainer, to buffer: inout [UInt8]) {

        /// Write the header
        write(header: .unkeyed, to: &buffer)

        /// Write -> Count
        pad(&buffer, for: Int32.self)
        buffer.append(contentsOf: withUnsafeBytes(of: Int32(storageContainer.count)) { Array($0) })

        for index in 0..<storageContainer.count {
            /// Write -> Element n
            write(storageContainer: storageContainer[index], to: &buffer)
        }
    }

    // MARK: - `KeyedStorageContainer` methods.

    ///
    /// Writes an `KeyedStorageContainer` to `buffer` and returns the number of bytes written.
    ///
    /// ```
    ///     |----------|-------|---------|-------|---------|
    ///     |  count   | Key 0 | Value 0 | Key n | Value n |
    ///     |----------|-------|---------|-------|---------|
    ///         Int32
    /// ```
    ///
    @inline(__always)
    private static func write(keyed storageContainer: KeyedStorageContainer, to buffer: inout [UInt8]) {

        /// Write the header
        write(header: .keyed, to: &buffer)

        /// Write -> count
        pad(&buffer, for: Int32.self)
        buffer.append(contentsOf: withUnsafeBytes(of: Int32(storageContainer.count)) { Array($0) })

        for (key, value) in storageContainer {

            /// Write - Key n
            write(string: key, to: &buffer)

            /// Write -> Value n
            write(storageContainer: value, to: &buffer)
        }
    }

    // MARK: - `String` methods.

    ///
    /// Writes a string (used for dictionary keys.)
    ///
    @inline(__always)
    private static func write(string: String, to buffer: inout [UInt8]) {
        let utf8 = string.utf8

        /// Store the size of the string
        pad(&buffer, for: Int32.self)
        buffer.append(contentsOf: withUnsafeBytes(of: Int32(utf8.count)) { Array($0) })

        /// Store the value
        pad(&buffer, for: Unicode.UTF8.CodeUnit.self)

        for codeUnit in utf8 {
            buffer.append(contentsOf: withUnsafeBytes(of: codeUnit) { Array($0) })
        }
    }

    // MARK: - `NullStorageContainer` methods.

    @inline(__always)
    private static func write(null: NullStorageContainer, to buffer: inout [UInt8]) {
        /// Write the header which is all we need to do
        write(header: .null, to: &buffer)
    }
}

///
/// Reads binary storage containers into `StorageContainer`.
///
internal class StorageContainerReader {

    ///
    /// Reads `buffer` into a root-level `StorageContainer`.
    ///
    /// - Parameter buffer: `UnsafeRawBufferPointer` to a representation previously written to by a writer.
    ///
    /// - Returns: `StorageContainer` representation of the raw buffer.
    ///
    @inline(__always)
    static func convert(_ bytes: [UInt8]) throws -> StorageContainer {
        return try bytes.withUnsafeBytes({ try read(from: $0[0...]).0 })
    }

    // MARK: - Private implementation

    ///
    ///  Reads a root-level `StorageContainer` from `buffer`.
    ///
    ///
    /// ```
    ///     |----------|-----------|
    ///     |  Header  | Container |
    ///     |----------|-----------|
    /// ```
    ///
    /* Do not inline, recursively called */
    private static func read(from buffer: Slice<UnsafeRawBufferPointer>) throws -> (StorageContainer, Int)   {

        var offset = align(offset: buffer.startIndex, to: Element.Header.self)

        /// Ensure we can load the header
        guard buffer.endIndex > offset && buffer.endIndex - offset >= MemoryLayout<Element.Header>.size
            else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Binary data does not contian a proper header.")) }

        /// Load the buffer header
        let header = UnsafeRawBufferPointer(rebasing: buffer[offset...]).load(as: Element.Header.self)

        offset += MemoryLayout<Element.Header>.size

        let container: (StorageContainer, Int)

        switch header.type {

        case .singleValue: container = try read(singleValueContainer:  buffer[offset...]); break
        case .unkeyed:     container = try read(unkeyedContainer:      buffer[offset...]); break
        case .keyed:       container = try read(keyedContainer:        buffer[offset...]); break
        case .null:        container = try read(nullContainer:         buffer[offset...]); break
        default:
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Binary data contains an unknown container type."))
        }
        return (container.0, container.1 + (offset - buffer.startIndex))
    }

    ///
    /// Reads a `SingleValueContainer` from `buffer`.
    ///
    /// The format is determed by the container iself since,
    /// in the case of the SingleValueContainer, it is already
    /// in byte form.
    /// ```
    ///     |-------|------|---------/ /--------|
    ///     | type  | size |       value        |
    ///     |-------|------|--------/ /---------|
    ///
    ///       Int32 | In32 | Determined by size
    /// ```
    @inline(__always)
    private static func read(singleValueContainer buffer: Slice<UnsafeRawBufferPointer>) throws -> (StorageContainer, Int)   {

        let container = try SingleValueContainer(from: buffer)

        return (container, container.byteCount)
    }

    ///
    ///  Reads a `UnkeyedStorageContainer` from `buffer`.
    ///
    ///
    /// ```
    ///     |----------|-----------|-----------|-----------|
    ///     |  count   | Element 0 | Element 1 | Element n |
    ///     |----------|-----------|-----------|-----------|
    ///         Int32
    /// ```
    ///
    @inline(__always)
    private static func read(unkeyedContainer buffer: Slice<UnsafeRawBufferPointer>) throws -> (StorageContainer, Int) {

        /// Find the count offset.
        var offset = align(offset: buffer.startIndex, to: Int32.self)

        /// Ensure we can load the header
        guard buffer.endIndex > offset && buffer.endIndex - offset >= MemoryLayout<Int32>.size
            else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Unkeyed container header missing or corrupt.")) }

        /// Read -> count
        let elementCount = UnsafeRawBufferPointer(rebasing: buffer[offset...]).load(as: Int32.self)

        let container = UnkeyedStorageContainer()

        offset += MemoryLayout<Int32>.size

        for _ in 0..<elementCount {

            /// Read -> Element n
            let (element, byteCount) = try read(from: buffer[offset...])

            /// Push the new element on to the result container
            container.push(element)

            offset += byteCount
        }
        return (container, offset - buffer.startIndex)
    }

    ///
    ///  Reads a `KeyedStorageContainer` from `buffer`.
    ///
    /// ```
    ///     |----------|-------|---------|-------|---------|
    ///     |  count   | Key 0 | Value 0 | Key n | Value n |
    ///     |----------|-------|---------|-------|---------|
    ///         Int32
    /// ```
    ///
    @inline(__always)
    private static func read(keyedContainer buffer: Slice<UnsafeRawBufferPointer>) throws -> (StorageContainer, Int) {

        /// Find the count offset.
        var offset = align(offset: buffer.startIndex, to: Int32.self)

        /// Ensure we can load the header
        guard buffer.endIndex > offset && buffer.endIndex - offset >= MemoryLayout<Int32>.size
            else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Keyed container header missing or corrupt.")) }

        /// Read -> count
        let elementCount = UnsafeRawBufferPointer(rebasing: buffer[offset...]).load(as: Int32.self)

        offset += MemoryLayout<Int32>.size

        let container = KeyedStorageContainer()

        for _ in 0..<elementCount {

            /// Read -> Key n
            let (key, keyByteCount) = try read(key: buffer[offset...])

            offset += keyByteCount

            /// Read -> Value n
            let (value, valueByteCount) = try read(from: buffer[offset...])

            /// Assign the key/value
            container[key] = value

            offset += valueByteCount
        }
        return (container, offset - buffer.startIndex)
    }

    ///
    ///  Reads a `String` from `buffer` (used for dictionary key storage).
    ///
    @inline(__always)
    private static func read(key buffer: Slice<UnsafeRawBufferPointer>) throws -> (String, Int) {

        /// Find the count offset.
        var offset = align(offset: buffer.startIndex, to: Int32.self)

        /// Ensure we can load the header
        guard buffer.endIndex > offset && buffer.endIndex - offset >= MemoryLayout<Int32>.size
            else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Key value header missing or corrupt.")) }

        /// Read -> count
        let count = UnsafeRawBufferPointer(rebasing: buffer[offset...]).load(as: Int32.self)

        guard count > 0
            else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Key value header missing or corrupt.")) }

        offset = align(offset: offset + MemoryLayout<Int32>.size, to: Unicode.UTF8.CodeUnit.self)

        /// Ensure we can load the value
        guard buffer.endIndex > offset && buffer.endIndex - offset >= count
            else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Key value corrupt, expected \(count) bytes but found \(buffer.count).")) }

        var utf8: [Unicode.UTF8.CodeUnit] = []

        for _ in 0..<count {
            utf8.append(UnsafeRawBufferPointer(rebasing: buffer[offset...]).load(as: Unicode.UTF8.CodeUnit.self))

            offset += MemoryLayout<Unicode.UTF8.CodeUnit>.stride
        }
        return (String(decoding: utf8, as: UTF8.self), offset - buffer.startIndex)
    }

    ///
    /// Reads a `NullStorageContainer` from `buffer`.
    ///
    @inline(__always)
    private static func read(nullContainer buffer: Slice<UnsafeRawBufferPointer>) throws -> (StorageContainer, Int) {
        return (NullStorageContainer.null, 0)
    }
}
