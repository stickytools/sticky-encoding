///
///  SingleValueContainer.swift
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
///  Created by Tony Stone on 10/24/17.
///
import Swift

///
/// Type which contains a single value in binary form.
///
/// The internal format of the binary representation consists
/// of the encoded type, size, and the value of the type.
///
/// ```
///     |-------|------|---------/ /--------|
///     | type  | size |       value        |
///     |-------|------|--------/ /---------|
///
///       Int32 | In32 | Determined by size
/// ```
///
internal class SingleValueContainer {

    ///
    /// Internal errors thrown by methods in this class.
    ///
    enum Error: Swift.Error {
        ///
        /// A typeMismatch occurs when a value is stored as one type and retrieved as a different type.
        ///
        case typeMismatch(Any.Type, EncodedType)
        ///
        /// Should any value not be in a state to store or retrieve, a valueCorrupt error will be thrown.
        ///
        case valueCorrupt(Any.Type, String)
    }

    ///
    /// Returns the `EncodedType` of the value encoded in `self`.
    ///
    var type: EncodedType {
        return self.buffer.load(fromByteOffset: Offset.type, as: EncodedType.self)
    }

    ///
    /// Returns the size in bytes of the value encoded in `self`.
    ///
    var size: Int {
        return Int(self.buffer.load(fromByteOffset: Offset.size, as: Int32.self))
    }

    ///
    /// Initializes `self` with an UnsafeMutableRawBufferPointer representing the underlying storage.
    ///
    @inline(__always)
    init(from buffer: UnsafeRawBufferPointer) throws {
        let tmp = UnsafeMutableRawBufferPointer.allocate(byteCount: buffer.count, alignment: MemoryLayout<UInt8>.alignment)
        tmp.copyMemory(from: buffer)
        self.buffer = UnsafeRawBufferPointer(tmp)
    }

    ///
    /// Initialize `self` with `value` of EncodableType `T`.
    ///
    /// - Parameter value: the value to be encoded into storage.
    ///
    @inline(__always)
    init<T: EncodableType>(_ value: T) {
        let encodedType = T.encodedType

        let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: Offset.value + MemoryLayout<T>.stride, alignment: MemoryLayout<UInt8>.alignment) // allocate(count: Offset.value + MemoryLayout<T>.stride)

        /// Store the type of stored data
        buffer.storeBytes(of: encodedType, toByteOffset: Offset.type, as: EncodedType.self)
        /// Store the size of the data
        buffer.storeBytes(of: Int32(MemoryLayout<T>.stride), toByteOffset: Offset.size, as: Int32.self)
        /// Store the value
        buffer.storeBytes(of: value, toByteOffset: Offset.value, as: T.self)

        self.buffer = UnsafeRawBufferPointer(buffer)
    }

    ///
    /// Initialize `self` with `value` of type `String`.
    ///
    /// - Parameter value: the `String` value to be encoded into storage.
    ///
    @inline(__always)
    init(_ value: String) {
        let utf8 = value.utf8

        let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: Offset.value + (utf8.count * MemoryLayout<Unicode.UTF8.CodeUnit>.stride), alignment: MemoryLayout<UInt8>.alignment)

        /// Store the type of stored data
        buffer.storeBytes(of: .string, toByteOffset: Offset.type, as: EncodedType.self)
        /// Store the size of the data
        buffer.storeBytes(of: Int32(utf8.count), toByteOffset: Offset.size, as: Int32.self)
        /// Store the value
        var offset = Offset.value
        for codeUnit in utf8 {
            buffer.storeBytes(of: codeUnit, toByteOffset: offset, as: Unicode.UTF8.CodeUnit.self)
            offset += MemoryLayout<Unicode.UTF8.CodeUnit>.stride
        }
        self.buffer = UnsafeRawBufferPointer(buffer)
    }

    deinit {
        buffer.deallocate()
    }

    ///
    /// Return the stored value as type `T`.
    ///
    /// - Parameter type: the type `T` to return the value as.
    ///
    /// - Throws: `SingleValueContainer.typeMisMatchError` if the requested `type` is not the type stored.
    /// - Throws: `SingleValueContainer.valueCorrupt` if the stored `T` value can not be created from storage.
    ///
    @inline(__always)
    func value<T: EncodableType>(as type: T.Type) throws -> T {
        guard self.type == T.encodedType
            else { throw SingleValueContainer.Error.typeMismatch(type, self.type) }

        guard self.buffer.count >= Offset.value + MemoryLayout<T>.stride
            else { throw SingleValueContainer.Error.valueCorrupt(type, "Not enough bytes stored to read value of type \(type).") }
        
        return self.buffer.load(fromByteOffset: Offset.value, as: type)
    }

    ///
    /// Return the stored value as type `String`.
    ///
    /// - Parameter type: the type `String` to return the value as.
    ///
    /// - Throws: `SingleValueContainer.typeMisMatchError` if the stored value is not a `String` type.
    /// - Throws: `SingleValueContainer.valueCorrupt` if the stored `String` value can not be created from storage.
    ///
    @inline(__always)
    func value(as type: String.Type) throws -> String  {
        guard self.type == EncodedType.string
            else { throw SingleValueContainer.Error.typeMismatch(type, self.type) }

        guard self.buffer.count >= Offset.value + self.size
            else { throw SingleValueContainer.Error.valueCorrupt(type, "Not enough bytes stored to read value of type \(type).") }

        var utf8: [Unicode.UTF8.CodeUnit] = []

        for i in 0..<self.size {
            utf8.append(self.buffer.load(fromByteOffset: Offset.value + i, as: Unicode.UTF8.CodeUnit.self))
        }
        return String(decoding: utf8, as: UTF8.self)
    }

    // MARK: - Private methods and vars

    internal static let HeaderSize = Offset.value

    ///
    /// Table of offsets into the raw storage buffer.
    ///
    private struct Offset {
        static let type  = 0
        static let size  = align(offset: MemoryLayout<EncodedType>.stride, to: Int32.self)
        static let value = align(offset: size, to: UnsafeRawPointer.self)
    }

    ///
    /// Internal storage of the binary representation of the encoded value.
    ///
    private var buffer: UnsafeRawBufferPointer
}

///
/// `StorageContainer` conformance.
///
extension SingleValueContainer: StorageContainer {

    ///
    /// Returns the byte count of the container and any overhead it requires.
    ///
    var byteCount: Int {
        return self.buffer.count
    }

    ///
    /// Write our contents to a buffer.
    ///
    func write(to buffer: UnsafeMutableRawBufferPointer) {
        buffer.copyMemory(from: self.buffer)
    }
}

///
/// `CustomStringConvertible` and `CustomDebugStringConvertible` conformance.
///
extension SingleValueContainer: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        do {
            switch self.type {
            case .bool:    return "\(try self.value(as: Bool.self))"
            case .int:     return "\(try self.value(as: Int.self))"
            case .int8:    return "\(try self.value(as: Int8.self))"
            case .int16:   return "\(try self.value(as: Int16.self))"
            case .int32:   return "\(try self.value(as: Int32.self))"
            case .int64:   return "\(try self.value(as: Int64.self))"
            case .uint:    return "\(try self.value(as: UInt.self))"
            case .uint8:   return "\(try self.value(as: UInt8.self))"
            case .uint16:  return "\(try self.value(as: UInt16.self))"
            case .uint32:  return "\(try self.value(as: UInt32.self))"
            case .uint64:  return "\(try self.value(as: UInt64.self))"
            case .float:   return "\(try self.value(as: Float.self))"
            case .double:  return "\(try self.value(as: Double.self))"
            case .string:  return "\(try self.value(as: String.self))"
            default:
                break
            }
        } catch {}
        return "Unknown"
    }

    public var debugDescription: String {
        return "SingleValueContainer(type: \(self.type), size: \(self.size), value: \(self.description))"
    }
}
