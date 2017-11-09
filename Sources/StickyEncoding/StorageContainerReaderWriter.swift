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
import StickyUtilities

fileprivate enum Error: Swift.Error {
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
///     |--------------------|---------/ /--------|--------------------|---------/ /--------|
///     |   Contianer Header |    Container Data  |   Container Header |    Container Data  |  ...
///     |--------------------|--------/ /---------|--------------------|--------/ /---------|
///
/// ```
///
fileprivate enum Raw {

    struct ContainerType: Equatable {
        static let null    = ContainerType(0xa)
        static let keyed   = ContainerType(0xb)
        static let unkeyed = ContainerType(0xc)
        static let value   = ContainerType(0xd)

        static func == (lhs: ContainerType, rhs: ContainerType) -> Bool {
            return lhs.value == rhs.value
        }
        private init(_ value: Int) {
            self.value = Int32(value)
        }
        private let value: Int32
    }

    ///
    /// Container Element Header
    ///
    struct ContainerHeader {
        init(_ type: ContainerType, byteCount: Int) {
            self.type  = type
            self.byteCount = Int32(byteCount)
        }
        let type: ContainerType
        let byteCount: Int32
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
    static func read(from buffer: UnsafeRawBufferPointer) -> StorageContainer {

        guard buffer.count >= MemoryLayout<Raw.ContainerHeader>.stride
            else { return NullStorageContainer.null }

        let (container, _) = read(from: buffer)

        return container
    }

    // MARK: - Private implementation

    ///
    ///  Reads a root-level `StorageContainer` from `buffer`.
    ///
    ///
    /// ```
    ///     |----------|---------/ /-----------|
    ///     |  Header  |     Container Data    |
    ///     |----------|--------/ /------------|
    /// ```
    ///
    /* Do not inline, recursively called */
    private static func read(from buffer: UnsafeRawBufferPointer) -> (StorageContainer, Int) {

        /// Load the buffer header
        let header = buffer.load(as: Raw.ContainerHeader.self)

        let containerOffset = align(offset: MemoryLayout<Raw.ContainerHeader>.stride, to: UnsafeRawPointer.self)
        let containerBuffer = UnsafeRawBufferPointer(rebasing: buffer[containerOffset..<containerOffset + Int(header.byteCount)])

        var storageContainer: StorageContainer

        switch header.type {

        case .keyed:   storageContainer = read(containerBuffer, as: KeyedStorageContainer.self);   break
        case .unkeyed: storageContainer = read(containerBuffer, as: UnkeyedStorageContainer.self); break
        case .value:   storageContainer = read(containerBuffer, as: SingleValueContainer.self);    break
        case .null: fallthrough
        default:    storageContainer = read(containerBuffer, as: NullStorageContainer.self);    break
        }
        return (storageContainer, containerOffset + containerBuffer.count)
    }

    ///
    /// Reads a `NullStorageContainer` from `buffer`.
    ///
    @inline(__always)
    private static func read(_ buffer: UnsafeRawBufferPointer, as: NullStorageContainer.Type) -> NullStorageContainer {
        return NullStorageContainer.null
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
    private static func read(_ buffer: UnsafeRawBufferPointer, as: KeyedStorageContainer.Type) -> KeyedStorageContainer {

        let container = KeyedStorageContainer()

        /// Read -> count
        let count = buffer.load(as: Int32.self)

        var elementOffset = align(offset: MemoryLayout<Int32>.stride, to: UnsafeRawPointer.self)

        for _ in 0..<Int32(count) {

            /// Read -> Key n
            let (key, keyByteCount) = read(UnsafeRawBufferPointer(rebasing: buffer[elementOffset...]), as: String.self)
            elementOffset = align(offset: elementOffset + keyByteCount, to: UnsafeRawPointer.self)

            /// Read -> Value n
            let (value, valueByteCount) = read(from: UnsafeRawBufferPointer(rebasing: buffer[elementOffset...]))
            elementOffset = align(offset: elementOffset + valueByteCount, to: UnsafeRawPointer.self)

            /// Assign the key/value
            container[key] = value
        }
        return container
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
    private static func read(_ buffer: UnsafeRawBufferPointer, as: UnkeyedStorageContainer.Type) -> UnkeyedStorageContainer {

        let container = UnkeyedStorageContainer()

        /// Read -> count
        let count = buffer.load(as: Int32.self)

        var elementOffset = align(offset: MemoryLayout<Int32>.stride, to: UnsafeRawPointer.self)

        for _ in 0..<Int32(count) {

            /// Read -> Element n
            let (element, byteCount) = read(from: UnsafeRawBufferPointer(rebasing: buffer[elementOffset...]))
            elementOffset = align(offset: elementOffset + byteCount, to: UnsafeRawPointer.self)

            /// Push the new element on to the result container
            container.push(element)
        }
        return container
    }

    ///
    ///  Reads a `SingleValueContainer` from `buffer`.
    ///
    @inline(__always)
    private static func read(_ buffer: UnsafeRawBufferPointer, as: SingleValueContainer.Type) -> SingleValueContainer {
        return SingleValueContainer(from: buffer)
    }

    ///
    ///  Reads a `String` from `buffer` (used for dictionary key storage).
    ///
    @inline(__always)
    private static func read(_ buffer: UnsafeRawBufferPointer, as: String.Type) -> (String, Int) {
        var utf8: [Unicode.UTF8.CodeUnit] = []

        let count = Int(buffer.load(as: Int32.self))
        let offset = align(offset: MemoryLayout<Int32>.stride, to: MemoryLayout<Unicode.UTF8.CodeUnit>.self)

        for i in 0..<count{
            utf8.append(buffer.load(fromByteOffset: offset + i, as: Unicode.UTF8.CodeUnit.self))
        }
        return (String(decoding: utf8, as: UTF8.self), offset + (MemoryLayout<Unicode.UTF8.CodeUnit>.stride * count))
    }
}

///
/// Writes StorageContainers to binary storage.
///
internal class StorageContainerWriter {

    @discardableResult
    @inline(__always)
    static func write(_ storageContainer: StorageContainer, to buffer: UnsafeMutableRawBufferPointer) -> Int {
        return write(storageContainer: storageContainer, to: buffer)
    }

    @inline(__always)
    static func byteCount(_ storageContainer: StorageContainer) -> Int {
        return byteCount(storageContainer: storageContainer)
    }

    // MARK: - Private methods

    // MARK: - Root level methods

    ///
    /// ```
    ///     |---------|------------|---------/ /-----------|
    ///     |  type   |  byteCount |        Data           |
    ///     |---------|------------|--------/ /------------|
    /// ```
    ///
    /* Do not inline, recursively called */
    private static func write(storageContainer: StorageContainer, to buffer: UnsafeMutableRawBufferPointer) -> Int {

        let elementOffset = align(offset: MemoryLayout<Raw.ContainerHeader>.stride, to: UnsafeRawPointer.self)
        let elementBuffer = UnsafeMutableRawBufferPointer(rebasing: buffer[elementOffset...])

        var header: Raw.ContainerHeader

        /// Write -> Data
        switch storageContainer {

        case let container as KeyedStorageContainer:   header = Raw.ContainerHeader(.keyed,   byteCount: write(keyed:   container, to: elementBuffer)); break
        case let container as UnkeyedStorageContainer: header = Raw.ContainerHeader(.unkeyed, byteCount: write(unkeyed: container, to: elementBuffer)); break
        case let container as SingleValueContainer:    header = Raw.ContainerHeader(.value,   byteCount: write(value:   container, to: elementBuffer)); break
        case is NullStorageContainer: fallthrough
        default: header = Raw.ContainerHeader(.null, byteCount: write(null: NullStorageContainer.null, to: elementBuffer)); break
        }

        /// Write -> Type/byteCount
        buffer.storeBytes(of: header, as: Raw.ContainerHeader.self)
        
        return elementOffset + Int(header.byteCount)
    }

    /* Do not inline, recursively called */
    private static func byteCount(storageContainer: StorageContainer) -> Int {

        var bytes = align(offset: MemoryLayout<Raw.ContainerHeader>.stride, to: UnsafeRawPointer.self)

        /// Write -> Data
        switch storageContainer {

        case let container as KeyedStorageContainer:   bytes = bytes + byteCount(keyed:   container); break
        case let container as UnkeyedStorageContainer: bytes = bytes + byteCount(unkeyed: container); break
        case let container as SingleValueContainer:    bytes = bytes + byteCount(value:   container); break
        case is NullStorageContainer: fallthrough
        default: bytes = bytes + byteCount(null: NullStorageContainer.null); break
        }
        return bytes
    }

    // MARK: - `NullStorageContainer` methods.

    @inline(__always)
    private static func write(null: NullStorageContainer, to buffer: UnsafeMutableRawBufferPointer) -> Int {
        return byteCount(null: null)
    }

    @inline(__always)
    private static func byteCount(null: NullStorageContainer) -> Int {
        return 0    /// Nothing to store for null
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
    private static func write(keyed storageContainer: KeyedStorageContainer, to buffer: UnsafeMutableRawBufferPointer) -> Int {

        /// Write -> count
        buffer.storeBytes(of: Int32(storageContainer.count), as: Int32.self)
        var byteCount = align(offset: MemoryLayout<Int32>.stride, to: UnsafeRawPointer.self)

        for (key, value) in storageContainer {

            /// Write - Key n
            let keyByteCount = write(string: key, to: UnsafeMutableRawBufferPointer(rebasing: buffer[byteCount...]))
            byteCount = align(offset: byteCount + keyByteCount, to: UnsafeRawPointer.self)

            /// Write -> Value n
            let valueByteCount = write(storageContainer: value, to: UnsafeMutableRawBufferPointer(rebasing: buffer[byteCount...]))
            byteCount = align(offset: byteCount + valueByteCount, to: UnsafeRawPointer.self)
        }
        return byteCount
    }

    @inline(__always)
    private static func byteCount(keyed storageContainer: KeyedStorageContainer) -> Int {

        var bytes = align(offset: MemoryLayout<Int32>.stride, to: UnsafeRawPointer.self)

        for (key, value) in storageContainer {
            bytes = align(offset: bytes + byteCount(string: key), to: UnsafeRawPointer.self)
            bytes = align(offset: bytes + byteCount(storageContainer: value),  to: UnsafeRawPointer.self)
        }
        return bytes
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
    private static func write(unkeyed storageContainer: UnkeyedStorageContainer, to buffer: UnsafeMutableRawBufferPointer) -> Int {

        /// Write -> Count
        buffer.storeBytes(of: Int32(storageContainer.count), as: Int32.self)
        var byteCount = align(offset: MemoryLayout<Int32>.stride, to: UnsafeRawPointer.self)

        for index in 0..<storageContainer.count {

            /// Write -> Element n
            let elementByteCount =  write(storageContainer: storageContainer[index], to: UnsafeMutableRawBufferPointer(rebasing: buffer[byteCount...]))
            byteCount = align(offset: byteCount + elementByteCount, to: UnsafeRawPointer.self)
        }
        return byteCount
    }

    @inline(__always)
    private static func byteCount(unkeyed storageContainer: UnkeyedStorageContainer) -> Int {
        var bytes = align(offset: MemoryLayout<Int32>.stride, to: UnsafeRawPointer.self)

        for index in 0..<storageContainer.count {
            bytes = align(offset: bytes + byteCount(storageContainer: storageContainer[index]), to: UnsafeRawPointer.self)
        }
        return bytes
    }

    // MARK: - `SingleValueContainer` methods.

    @inline(__always)
    private static func write(value storageContainer: SingleValueContainer, to buffer: UnsafeMutableRawBufferPointer) -> Int {
        storageContainer.write(to: buffer)
        return storageContainer.byteCount
    }

    @inline(__always)
    private static func byteCount(value storageContainer: SingleValueContainer) -> Int {
        return storageContainer.byteCount
    }

    // MARK: - `String` methods.

    ///
    /// Writes a string (used for dictionary keys.)
    ///
    @inline(__always)
    private static func write(string: String, to buffer: UnsafeMutableRawBufferPointer) -> Int {
        let utf8 = string.utf8

        /// Store the size of the string
        buffer.storeBytes(of: Int32(utf8.count), as: Int32.self)
        
        /// Store the value
        var offset = align(offset: MemoryLayout<Int32>.stride, to: MemoryLayout<Unicode.UTF8.CodeUnit>.self)
        for codeUnit in utf8 {
            buffer.storeBytes(of: codeUnit, toByteOffset: offset, as: Unicode.UTF8.CodeUnit.self)
            offset = offset + MemoryLayout<Unicode.UTF8.CodeUnit>.stride
        }
        return offset
    }

    @inline(__always)
    private static func byteCount(string: String) -> Int {
        let bytes = align(offset: MemoryLayout<Int32>.stride, to: MemoryLayout<Unicode.UTF8.CodeUnit>.self)
        
        return bytes + (MemoryLayout<Unicode.UTF8.CodeUnit>.stride * string.count)
    }
}
