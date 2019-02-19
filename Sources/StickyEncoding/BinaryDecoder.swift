///
///  BinaryDecoder.swift
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
///  Created by Tony Stone on 10/6/17.
///
import Foundation

///
/// `BinaryDecoder` facilitates the decoding of binary values into semantic `Decodable` types.
///
open class BinaryDecoder {

    /// Initializes `self`.
    public init(userInfo: [CodingUserInfoKey : Any] = [:]) {
        self.userInfo = userInfo
    }

    ///
    /// Decodes a top-level value of the given type `T` from the Binary representation `data`.
    ///
    /// - parameter:
    ///     - type: The type of the value to decode.
    ///     - data: The data to decode from.
    ///
    /// - returns: A value of the requested type `T`.
    ///
    /// - throws: `DecodingError.dataCorrupted` if values requested from the payload are corrupted, or if the given data is not valid.
    /// - throws: An error if any value throws an error during decoding.
    ///
    open func decode<T : Decodable>(_ type: T.Type, from data: EncodedData) throws -> T {
        return try T.init(from: _BinaryDecoder(codingPath: [], rootStorage: data.storage, userInfo: self.userInfo))
    }

    public var userInfo: [CodingUserInfoKey : Any]
}

// MARK: -

///
/// Private class implementing the `Decoder` protocol
///
private class _BinaryDecoder : Decoder {

    // MARK: - Initialization

    ///
    /// Init with the current codingPath and a `StorageContainerReference` which will be filled with
    /// the result of this containers encoding.
    ///
    /// - Parameters:
    ///     - codingPath:   The path of coding keys taken to get to this point in decoding.
    ///     - rootStorage:  The rootStorage container used for decoding values.
    ///
    init(codingPath: [CodingKey], rootStorage: StorageContainer, userInfo: [CodingUserInfoKey : Any]) {
        self.rootStorage = rootStorage
        self.codingPath = codingPath
        self.userInfo   = userInfo
    }

    // MARK: - `Decoder` conformance.

    var codingPath: [CodingKey]

    var userInfo: [CodingUserInfoKey : Any]

    ///
    /// - throws: `DecodingError.typeMismatch` if the encountered stored value is not a keyed container.
    ///
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        let storage = try storageContainer(KeyedStorageContainer.self, errorType: KeyedDecodingContainer<Key>.self)

        return KeyedDecodingContainer(_BinaryKeyedDecodingContainer<Key>(referencing: self, codingPath: self.codingPath, rootStorage: storage))
    }

    ///
    /// - throws: `DecodingError.typeMismatch` if the encountered stored value is not an unkeyed container.
    ///
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        let storage = try storageContainer(UnkeyedStorageContainer.self, errorType: UnkeyedDecodingContainer.self)

        return _BinaryUnkeyedDecodingContainer(referencing: self, codingPath: codingPath, rootStorage: storage)
    }

    ///
    /// - throws: `DecodingError.typeMismatch` if the encountered stored value is not a single value container.
    ///
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        return _BinarySingleValueDecodingContainer(referencing: self, codingPath: codingPath, storage: self.rootStorage)
    }

    // MARK: - Private methods and storage.

    ///
    /// Converts the root storage into the required type or throws an appropriate error if it can't.
    ///
    @inline(__always)
    private func storageContainer<T,E>(_ type: T.Type, errorType: E.Type) throws -> T {
        guard !(self.rootStorage is NullStorageContainer)
            else { throw DecodingError.valueNotFoundError(at: self.codingPath, expected: errorType) }
        guard let storage = self.rootStorage as? T
            else { throw DecodingError.typeMismatchError(at: self.codingPath, expected: errorType, actual: self.rootStorage) }
        return storage
    }

    ///
    /// For each instance of the decoder, there is only one
    /// root storage container which can be a `SingleValueContainer`,
    /// a `UnkeyedStorageContainer`, or a `KeyStorageContainer`.
    ///
    private var rootStorage: StorageContainer
}

// MARK: - Containers

///
/// Decoding containers used by `_BinaryDecoder`.
///
extension _BinaryDecoder {

    // MARK: -

    ///
    ///  Decoding container which decodes values from a keyed (Dictionary type) storage container.
    ///
    private struct _BinaryKeyedDecodingContainer<K : CodingKey> : KeyedDecodingContainerProtocol {

        ///
        /// Init with the current codingPath and a `KeyedStorageContainer` which will be filled with
        /// the result of this containers encoding.
        ///
        /// - Parameters:
        ///     - codingPath:   The path of coding keys taken to get to this point in decoding.
        ///     - rootStorage:  The `KeyedStorageContainer` used for decoding values.
        ///
        init(referencing decoder: _BinaryDecoder, codingPath: [CodingKey], rootStorage: KeyedStorageContainer) {
            self.decoder     = decoder
            self.rootStorage = rootStorage
            self.codingPath  = codingPath
        }

        // MARK: - `KeyedDecodingContainerProtocol` conformance.

        var codingPath: [CodingKey]

        var allKeys: [K] {
            return self.rootStorage.keys.compactMap { K(stringValue: $0) }
        }

        func contains(_ key: K) -> Bool { return self.rootStorage.contains(key.stringValue) }

        ///
        /// Check if the value at `key` is `NullStorageContainer` and returns `true` if it is.
        ///
        /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry for the given key.
        ///
        func decodeNil(forKey key: K) throws -> Bool {
            ///
            /// Note: The encoder will encode a nil value if nil
            ///       or the actual value if not nil.
            ///
            ///       This should only consume the value if the
            ///       value is nil.
            ///
            guard let storage = self.rootStorage[key.stringValue]
                else { throw DecodingError.keyNotFoundError(at: self.codingPath + key, forKey: key) }

            return storage is NullStorageContainer
        }

        func decode(_ type: Bool.Type,   forKey key: K) throws -> Bool   { return try _decode(type, forKey: key) }
        func decode(_ type: Int.Type,    forKey key: K) throws -> Int    { return try _decode(type, forKey: key) }
        func decode(_ type: Int8.Type,   forKey key: K) throws -> Int8   { return try _decode(type, forKey: key) }
        func decode(_ type: Int16.Type,  forKey key: K) throws -> Int16  { return try _decode(type, forKey: key) }
        func decode(_ type: Int32.Type,  forKey key: K) throws -> Int32  { return try _decode(type, forKey: key) }
        func decode(_ type: Int64.Type,  forKey key: K) throws -> Int64  { return try _decode(type, forKey: key) }
        func decode(_ type: UInt.Type,   forKey key: K) throws -> UInt   { return try _decode(type, forKey: key) }
        func decode(_ type: UInt8.Type,  forKey key: K) throws -> UInt8  { return try _decode(type, forKey: key) }
        func decode(_ type: UInt16.Type, forKey key: K) throws -> UInt16 { return try _decode(type, forKey: key) }
        func decode(_ type: UInt32.Type, forKey key: K) throws -> UInt32 { return try _decode(type, forKey: key) }
        func decode(_ type: UInt64.Type, forKey key: K) throws -> UInt64 { return try _decode(type, forKey: key) }
        func decode(_ type: Float.Type,  forKey key: K) throws -> Float  { return try _decode(type, forKey: key) }
        func decode(_ type: Double.Type, forKey key: K) throws -> Double { return try _decode(type, forKey: key) }

        ///
        /// Decodes a single `String` value and returns it.
        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered `StorageContainer` is not convertible to a `SingleValueContainer`.
        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered encoded value is not convertible to the requested type.
        /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry for the given key.
        /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for the given key.
        ///
        func decode(_ type: String.Type, forKey key: K) throws -> String {
            let storage = try storageContainer(SingleValueContainer.self, forKey: key, errorType: type)

            do {
                return try storage.value(as: type)
            } catch SingleValueContainer.Error.typeMismatch(_, let actualType) {
                throw DecodingError.typeMismatchError(at: self.codingPath + key, expected: type, actual: actualType)
            }
        }

        ///
        /// Decodes any object type by calling a new instance of the Decoder.
        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered encoded value is not convertible to the requested type.
        /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry for the given key.
        /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for the given key.
        ///
        /// - Note: this method will also rethrow any errors thrown by the new Decoder instance created duing the decode process.
        ///
        func decode<T: Decodable >(_ type: T.Type, forKey key: K) throws -> T {
            let storage = try storageContainer(StorageContainer.self, forKey: key, errorType: type)

            return try T.init(from: _BinaryDecoder(codingPath: self.codingPath + key, rootStorage: storage, userInfo: self.decoder.userInfo))
        }

        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered stored value is not a keyed container.
        ///
        func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: K) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
            let storage = try storageContainer(KeyedStorageContainer.self, forKey:  key, errorType: KeyedDecodingContainer<NestedKey>.self)

            return KeyedDecodingContainer(_BinaryKeyedDecodingContainer<NestedKey>(referencing: self.decoder, codingPath: self.codingPath + key, rootStorage: storage))
        }

        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered stored value is not an unkeyed container.
        ///
        func nestedUnkeyedContainer(forKey key: K) throws -> UnkeyedDecodingContainer {
            let storage = try storageContainer(UnkeyedStorageContainer.self, forKey:  key, errorType: UnkeyedDecodingContainer.self)

            return _BinaryUnkeyedDecodingContainer(referencing: self.decoder, codingPath: self.codingPath + key, rootStorage: storage)
        }

        ///
        /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry for the given key.
        /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for the given key.
        ///
        func superDecoder(forKey key: K) throws -> Decoder {
            let storage = try storageContainer(StorageContainer.self, forKey: key, errorType: Decoder.self)

            return _BinaryDecoder(codingPath: self.codingPath + key, rootStorage: storage, userInfo: self.decoder.userInfo)
        }

        ///
        /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry for the default `super` key.
        /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for the default `super` key.
        ///
        func superDecoder() throws -> Decoder {
            let storage = try storageContainer(StorageContainer.self, forKey: BinaryCodingKey("super"), errorType: Decoder.self)

            return _BinaryDecoder(codingPath: self.codingPath, rootStorage: storage, userInfo: self.decoder.userInfo)
        }

        // MARK: - Private methods and storage

        ///
        /// Decodes any single value type defined as an `EncodableType` returning an instance of `T` type.
        ///
        /// - Note: Can be used on all Single value types accept `String`
        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered `StorageContainer` is not convertible to a `SingleValueContainer`.
        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered encoded value is not convertible to the requested type.
        /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry for the given key.
        /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for the given key.
        ///
        @inline(__always)
        private func _decode<T: EncodableType>(_ type: T.Type, forKey key: K) throws -> T {
            let storage = try storageContainer(SingleValueContainer.self, forKey: key, errorType: type)

            do {
                return try storage.value(as: type)
            } catch SingleValueContainer.Error.typeMismatch(_, let actualType) {
                throw DecodingError.typeMismatchError(at: self.codingPath + key, expected: type, actual: actualType)
            }
        }

        ///
        /// Checks for key and if found converts that `StorageContainer` to the specific `type` requested or throws an appropriate `DecodingError` if there is no value for the key or its of the wrong type.
        ///
        /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry for the given key.
        /// - throws: `DecodingError.typeMismatch` if the encountered value is not an `T` type container returning the message as the `E` type.
        ///
        @inline(__always)
        private func storageContainer<T,E>(_ type: T.Type, forKey key: CodingKey, errorType: E.Type) throws -> T {
            guard let storage = self.rootStorage[key.stringValue]
                else { throw DecodingError.keyNotFoundError(at: self.codingPath + key, forKey: key) }
            guard !(storage is NullStorageContainer)
                else { throw DecodingError.valueNotFoundError(at: self.codingPath + key, expected: errorType) }
            guard let typedStorage = storage as? T
                else { throw DecodingError.typeMismatchError(at: self.codingPath + key, expected: errorType, actual: storage) }
            return typedStorage
        }

        /// The decoder this container was created from.
        ///
        private let decoder: _BinaryDecoder

        /// The root storage for this container.
        ///
        private var rootStorage: KeyedStorageContainer
    }

    // MARK: -

    ///
    ///  Decoding container which decodes values from an unkeyed (Array type) storage container.
    ///
    private struct _BinaryUnkeyedDecodingContainer : UnkeyedDecodingContainer {

        ///
        /// Init with the current codingPath and a `UnkeyedStorageContainer` which will be filled with
        /// the result of this containers encoding.
        ///
        /// - Parameters:
        ///     - codingPath:   The path of coding keys taken to get to this point in decoding.
        ///     - rootStorage:  The `UnkeyedStorageContainer` used for decoding values.
        ///
        init(referencing decoder: _BinaryDecoder, codingPath: [CodingKey], rootStorage: UnkeyedStorageContainer) {
            self.decoder      = decoder
            self.rootStorage  = rootStorage
            self.codingPath   = codingPath
            self.currentIndex = 0
        }

        // MARK: - `UnkeyedDecodingContainer` conformance.

        var count: Int? { return rootStorage.count }

        var isAtEnd: Bool { return currentIndex >= rootStorage.count }

        var currentIndex: Int

        var codingPath: [CodingKey]

        ///
        /// Check if the next value is `NullStorageContainer` and returns `true` if it is.
        ///
        /// - throws: `DecodingError.valueNotFound` if there are no more values to decode.
        ///
        mutating func decodeNil() throws -> Bool {
            ///
            /// Note: The encoder will encode a nil value if nil
            ///       or the actual value if not nil.
            ///
            ///       This should only consume the value if the
            ///       value is nil.
            ///
            guard currentIndex < rootStorage.count
                else { throw DecodingError.valueNotFoundError(at: self.codingPath, expected: SingleValueDecodingContainer.self, isAtEnd: true) }

            if rootStorage[currentIndex] is NullStorageContainer {
                currentIndex += 1
                return true
            }
            return false
        }

        mutating func decode(_ type: Bool.Type)   throws -> Bool    { return try _decode(type) }
        mutating func decode(_ type: Int.Type)    throws -> Int     { return try _decode(type) }
        mutating func decode(_ type: Int8.Type)   throws -> Int8    { return try _decode(type) }
        mutating func decode(_ type: Int16.Type)  throws -> Int16   { return try _decode(type) }
        mutating func decode(_ type: Int32.Type)  throws -> Int32   { return try _decode(type) }
        mutating func decode(_ type: Int64.Type)  throws -> Int64   { return try _decode(type) }
        mutating func decode(_ type: UInt.Type)   throws -> UInt    { return try _decode(type) }
        mutating func decode(_ type: UInt8.Type)  throws -> UInt8   { return try _decode(type) }
        mutating func decode(_ type: UInt16.Type) throws -> UInt16  { return try _decode(type) }
        mutating func decode(_ type: UInt32.Type) throws -> UInt32  { return try _decode(type) }
        mutating func decode(_ type: UInt64.Type) throws -> UInt64  { return try _decode(type) }
        mutating func decode(_ type: Float.Type)  throws -> Float   { return try _decode(type) }
        mutating func decode(_ type: Double.Type) throws -> Double  { return try _decode(type) }

        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered encoded value is not convertible to the requested type.
        /// - throws: `DecodingError.valueNotFound` if the encountered encoded value is null, or of there are no more values to decode.
        ///
        mutating func decode(_ type: String.Type) throws -> String  {
            let storage = try self.nextStorageContainer(as: SingleValueContainer.self, errorType: type)

            do {
                return try storage.value(as: type)
            } catch SingleValueContainer.Error.typeMismatch(_, let actualType) {
                throw DecodingError.typeMismatchError(at: self.codingPath, expected: type, actual: actualType)
            }
        }

        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered encoded value is not convertible to the requested type.
        /// - throws: `DecodingError.valueNotFound` if the encountered encoded value is null, or of there are no more values to decode.
        ///
        mutating func decode<T: Decodable>(_ type: T.Type)   throws -> T {
            let storage = try self.nextStorageContainer(as: StorageContainer.self, errorType: type)

            return try T.init(from: _BinaryDecoder(codingPath: self.codingPath, rootStorage: storage, userInfo: self.decoder.userInfo))
        }

        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered stored value is not a keyed container.
        ///
        mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
            let storage = try self.nextStorageContainer(as: KeyedStorageContainer.self, errorType: KeyedDecodingContainer<NestedKey>.self)

            return KeyedDecodingContainer<NestedKey>(_BinaryKeyedDecodingContainer(referencing: self.decoder, codingPath: self.codingPath, rootStorage: storage))
        }

        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered stored value is not an unkeyed container.
        ///
        mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
            let storage = try self.nextStorageContainer(as: UnkeyedStorageContainer.self, errorType: UnkeyedDecodingContainer.self)

            return _BinaryUnkeyedDecodingContainer(referencing: self.decoder, codingPath: self.codingPath, rootStorage: storage)
        }

        ///
        /// - throws: `DecodingError.valueNotFound` if the encountered encoded value is null, or of there are no more values to decode.
        ///
        mutating func superDecoder() throws -> Decoder {
            ///
            /// Note: Due to the semantics of superDecoder and the errors it throws, we treat getting
            ///       a container as a special case so we can accommodate.
            ///
            guard currentIndex < rootStorage.count
                else { throw DecodingError.valueNotFoundError(at: self.codingPath, expected: Decoder.self, isAtEnd: true) }
            guard !(rootStorage[currentIndex] is NullStorageContainer)
                else { throw DecodingError.valueNotFoundError(at: self.codingPath, expected: Decoder.self) }

            defer { currentIndex += 1 }

            return _BinaryDecoder(codingPath: self.codingPath, rootStorage: rootStorage[currentIndex], userInfo: self.decoder.userInfo)
        }

        // MARK: - Private methods and storage.

        ///
        /// Decodes any single value type defined as an `EncodableType` returning an instance of `T` type.
        ///
        /// - Note: Can be used on all Single value types accept `String`
        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered encoded value is not convertible to the requested type.
        /// - throws: `DecodingError.valueNotFound` if the encountered encoded value is null, or of there are no more values to decode.
        ///
        @inline(__always)
        private mutating func _decode<T: EncodableType>(_ type: T.Type) throws -> T {
            let storage = try self.nextStorageContainer(as: SingleValueContainer.self, errorType: type)

            do {
                return try storage.value(as: type)
            } catch SingleValueContainer.Error.typeMismatch(_, let actualType) {
                throw DecodingError.typeMismatchError(at: self.codingPath, expected: type, actual: actualType)
            }
        }

        ///
        /// Checks if there is another `StorageContainer` available and it so converts it to the specific `type` requested.  If there are no containers left or it can't convert it to the requested type an appropriate `DecodingError` error will be thrown.
        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered encoded value is not convertible to the requested type.
        /// - throws: `DecodingError.valueNotFound` if the encountered encoded value is null, or of there are no more values to decode.
        ///
        @inline(__always)
        private mutating func nextStorageContainer<T,E>(as type: T.Type, errorType: E.Type) throws -> T {
            guard currentIndex < rootStorage.count
                else { throw DecodingError.valueNotFoundError(at: self.codingPath, expected: errorType, isAtEnd: true) }
            guard !(rootStorage[currentIndex] is NullStorageContainer)
                else { throw DecodingError.valueNotFoundError(at: self.codingPath, expected: errorType) }
            guard let storage = rootStorage[currentIndex] as? T
                else { throw DecodingError.typeMismatchError(at: self.codingPath, expected: errorType, actual: rootStorage[currentIndex]) }

            currentIndex += 1

            return storage
        }

        /// The decoder this container was created from.
        ///
        private let decoder: _BinaryDecoder

        /// The root storage for this container.
        ///
        private var rootStorage: UnkeyedStorageContainer
    }

    // MARK: -

    ///
    ///  Decoding container which decodes a single primitive type.
    ///
    private struct _BinarySingleValueDecodingContainer: SingleValueDecodingContainer {

        ///
        /// Init with the current codingPath and a `StorageContainer` containing
        /// the value to decode.
        ///
        /// - Parameters:
        ///     - codingPath:   The path of coding keys taken to get to this point in decoding.
        ///     - rootStorage:  The `StorageContainer` containing the value to decode.
        ///
        init(referencing decoder: _BinaryDecoder, codingPath: [CodingKey], storage: StorageContainer) {
            self.decoder     = decoder
            self.codingPath  = codingPath
            self.rootStorage = storage
        }

        // MARK: - `SingleValueDecodingContainer` conformance.

        var codingPath: [CodingKey]

        ///
        /// Decodes whether a value is nil.
        ///
        func decodeNil() -> Bool {
            return self.rootStorage is NullStorageContainer
        }

        func decode(_ type: Bool.Type)   throws -> Bool    { return try _decode(type) }
        func decode(_ type: Int.Type)    throws -> Int     { return try _decode(type) }
        func decode(_ type: Int8.Type)   throws -> Int8    { return try _decode(type) }
        func decode(_ type: Int16.Type)  throws -> Int16   { return try _decode(type) }
        func decode(_ type: Int32.Type)  throws -> Int32   { return try _decode(type) }
        func decode(_ type: Int64.Type)  throws -> Int64   { return try _decode(type) }
        func decode(_ type: UInt.Type)   throws -> UInt    { return try _decode(type) }
        func decode(_ type: UInt8.Type)  throws -> UInt8   { return try _decode(type) }
        func decode(_ type: UInt16.Type) throws -> UInt16  { return try _decode(type) }
        func decode(_ type: UInt32.Type) throws -> UInt32  { return try _decode(type) }
        func decode(_ type: UInt64.Type) throws -> UInt64  { return try _decode(type) }
        func decode(_ type: Float.Type)  throws -> Float   { return try _decode(type) }
        func decode(_ type: Double.Type) throws -> Double  { return try _decode(type) }

        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered encoded value cannot be converted to the requested type.
        /// - throws: `DecodingError.valueNotFound` if the encountered encoded value is null.
        ///
        func decode(_ type: String.Type) throws -> String  {
            guard !(rootStorage is NullStorageContainer)
                else { throw DecodingError.valueNotFoundError(at: self.codingPath, expected: type) }
            guard let storage = rootStorage as? SingleValueContainer
                else { throw DecodingError.typeMismatchError(at: self.codingPath, expected: type, actual: rootStorage) }

            do {
                return try storage.value(as: type)
            } catch SingleValueContainer.Error.typeMismatch(_, let actualType) {
                throw DecodingError.typeMismatchError(at: self.codingPath, expected: type, actual: actualType)
            }
        }

        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered encoded value cannot be converted to the requested type.
        /// - throws: `DecodingError.valueNotFound` if the encountered encoded value is null.
        ///
        func decode<T: Decodable>(_ type: T.Type) throws -> T {
            guard !(rootStorage is NullStorageContainer)
                else { throw DecodingError.valueNotFoundError(at: self.codingPath, expected: type) }

            ///
            /// Object values are a special case here.  We can't decode them in a primitive Single value container
            /// as they are not meant to support that type.
            ///
            /// Instead we create a new _BinaryDecoder and pass the storage reference up to that decoder
            /// which will then decode the value.
            ///
            return try T.init(from: _BinaryDecoder(codingPath: self.codingPath, rootStorage: rootStorage, userInfo: self.decoder.userInfo))
        }

        // MARK: - Private methods and storage

        ///
        /// Decodes any single value type defined as an `EncodableType` returning an instance of `T` type.
        ///
        /// - Note: Can be used on all Single value types accept `String`
        ///
        /// - throws: `DecodingError.typeMismatch` if the encountered encoded value cannot be converted to the requested type.
        /// - throws: `DecodingError.valueNotFound` if the encountered encoded value is null.
        ///
        @inline(__always)
        private func _decode<T: EncodableType>(_ type: T.Type) throws -> T {
            guard !(rootStorage is NullStorageContainer)
                else { throw DecodingError.valueNotFoundError(at: self.codingPath, expected: type) }
            guard let storage = rootStorage as? SingleValueContainer
                else { throw DecodingError.typeMismatchError(at: self.codingPath, expected: type, actual: rootStorage) }

            do {
                return try storage.value(as: type)
            } catch SingleValueContainer.Error.typeMismatch(_, let actualType) {
                throw DecodingError.typeMismatchError(at: self.codingPath, expected: type, actual: actualType)
            }
        }

        /// The decoder this container was created from.
        ///
        private let decoder: _BinaryDecoder

        /// The root storage for this container.
        ///
        private var rootStorage: StorageContainer
    }
}
