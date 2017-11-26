///
///  BinaryEncoder.swift
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
/// `BinaryEncoder` facilitates the encoding of `Encodable` values into a binary format StickyDB can store on disk.
///
open class BinaryEncoder {

    ///
    /// Initializes `self`.
    ///
    public init() {}

    ///
    /// Encodes the given top-level value and returns its Binary representation.
    ///
    /// - parameters:
    ///     - value: The value to be encoded.
    ///
    /// - returns: A new `EncodedData` value containing the encoded Binary data.
    ///
    /// - throws: An error if any value throws an error during encoding.
    ///
    open func encode<T: Encodable>(_ value: T) throws -> EncodedData {
        let encoder = _BinaryEncoder(codingPath: [])
        try value.encode(to: encoder)

        if let storage = encoder.rootStorage.value {
            return EncodedData(storage)
        }
        return EncodedData(NullStorageContainer.null)
    }
}

// MARK: -

///
/// Main Encoder class
///
private class _BinaryEncoder : Encoder {

    // MARK: - Initialization

    ///
    /// Init with the current codingPath and a default `PassthroughReference` (local storage) which will be filled with
    /// the result of this containers encoding.
    ///
    /// - Parameters:
    ///     - codingPath:   The path of coding keys taken to get to this point in encoding.
    ///
    init(codingPath: [CodingKey]) {
        self.rootStorage = PassthroughReference()
        self.codingPath = codingPath
        self.userInfo = [:]
    }

    ///
    /// Init with the current codingPath and a `StorageContainerReference` which will be filled with
    /// the result of this containers encoding.
    ///
    /// - Parameters:
    ///     - codingPath:   The path of coding keys taken to get to this point in encoding.
    ///     - rootStorage:  The rootStorage container for storing the results from this containers encoding.  This is a reference element that will be filled by this class.
    ///
    init(codingPath: [CodingKey], rootStorage: StorageContainerReference) {
        self.rootStorage = rootStorage
        self.codingPath = codingPath
        self.userInfo = [:]
    }

    // MARK: - `Encoder` conformance.

    ///
    /// The path of coding keys taken to get to this point in encoding.
    ///
    /// - Note: At this point this should be empty
    ///
    public var codingPath: [CodingKey]

    ///
    /// Any contextual information set by the user for encoding.
    ///
    public var userInfo: [CodingUserInfoKey : Any]

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        let storageContainer: KeyedStorageContainer

        if let container = self.rootStorage.value as? KeyedStorageContainer {
            storageContainer = container
        } else {
            storageContainer = KeyedStorageContainer()
            self.rootStorage.value = storageContainer
        }

        return KeyedEncodingContainer(_BinaryKeyedEncodingContainer<Key>(codingPath: codingPath, rootStorage: storageContainer))
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        let storageContainer: UnkeyedStorageContainer

        if let container = self.rootStorage.value as? UnkeyedStorageContainer {
            storageContainer = container
        } else {
            storageContainer = UnkeyedStorageContainer()
            self.rootStorage.value = storageContainer
        }
        return _BinaryUnkeyedEncodingContainer(codingPath: codingPath, rootStorage: storageContainer)
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        return _BinarySingleValueEncodingContainer(codingPath: codingPath, rootStorage: self.rootStorage)
    }

    ///
    /// For each instance of the encoder, there is only one
    /// root storage container which can be a `SingleValueContainer`,
    /// a `UnkeyedStorageContainer`, or a `KeyStorageContainer`.
    ///
    var rootStorage: StorageContainerReference
}

// MARK: - Containers

///
/// Encoding containers used by `_BinaryEncoder`.
///
extension _BinaryEncoder {

    // MARK: -

    ///
    ///  Encoding container which encodes values into an keyed (Dictionary type) container.
    ///
    private struct _BinaryKeyedEncodingContainer<K : CodingKey>: KeyedEncodingContainerProtocol  {

        // MARK: - Initialization

        ///
        /// Init with the current codingPath and a `KeyedStorageContainer` which will be filled with
        /// the result of this containers encoding.
        ///
        /// - Parameters:
        ///     - codingPath:   The path of coding keys taken to get to this point in encoding.
        ///     - rootStorage:  The rootStorage container for storing the results from this containers encoding.
        ///
        init(codingPath: [CodingKey], rootStorage: KeyedStorageContainer) {
            self.rootStorage = rootStorage
            self.codingPath = codingPath
        }

        // MARK: - `KeyedEncodingContainerProtocol` conformance

        /// The path of coding keys taken to get to this point in encoding.
        var codingPath: [CodingKey]

        mutating func encodeNil(forKey key: K) throws { self.rootStorage[key.stringValue] = NullStorageContainer.null }

        ///
        /// All encode types accpet encodeNil can throw the following.
        //
        /// - throws: `EncodingError.invalidValue` if the given value is invalid in the current context for this format.
        ///
        mutating func encode(_ value: Bool,   forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }
        mutating func encode(_ value: Int,    forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }
        mutating func encode(_ value: Int8,   forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }
        mutating func encode(_ value: Int16,  forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }
        mutating func encode(_ value: Int32,  forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }
        mutating func encode(_ value: Int64,  forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }
        mutating func encode(_ value: UInt,   forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }
        mutating func encode(_ value: UInt8,  forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }
        mutating func encode(_ value: UInt16, forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }
        mutating func encode(_ value: UInt32, forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }
        mutating func encode(_ value: UInt64, forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }
        mutating func encode(_ value: Float,  forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }
        mutating func encode(_ value: Double, forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }
        mutating func encode(_ value: String, forKey key: K) throws { self.rootStorage[key.stringValue] = SingleValueContainer(value) }

        ///
        /// - throws: `EncodingError.invalidValue` if the given value is invalid in the current context for this format.
        ///
        mutating func encode<T: Encodable>(_ value: T, forKey key: K) throws {
            let encoder = _BinaryEncoder(codingPath: self.codingPath + key, rootStorage: self.rootStorage.elementReference(for: key.stringValue))
            try value.encode(to: encoder)
        }

        mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: K) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
            let storage = KeyedStorageContainer()
            self.rootStorage[key.stringValue] = storage

            return KeyedEncodingContainer(_BinaryKeyedEncodingContainer<NestedKey>(codingPath: self.codingPath + key, rootStorage: storage))
        }

        mutating func nestedUnkeyedContainer(forKey key: K) -> UnkeyedEncodingContainer {
            let storage = UnkeyedStorageContainer()
            self.rootStorage[key.stringValue] = storage

            return _BinaryUnkeyedEncodingContainer(codingPath: self.codingPath + key, rootStorage: storage)
        }

        mutating func superEncoder(forKey key: K) -> Encoder {
            return _BinaryEncoder(codingPath: self.codingPath + key, rootStorage: self.rootStorage.elementReference(for: key.stringValue))
        }

        mutating func superEncoder() -> Encoder {
            return _BinaryEncoder(codingPath: self.codingPath, rootStorage: self.rootStorage.elementReference(for: "super"))
        }

        // MARK: - Private methods and storage.

        private var rootStorage: KeyedStorageContainer
    }

    // MARK: -

    ///
    ///  Encoding container which encodes values into an unkeyed (Array type) container.
    ///
    private struct _BinaryUnkeyedEncodingContainer: UnkeyedEncodingContainer {

        // MARK: - Initialization

        ///
        /// Init with the current codingPath and an `UnkeyedStorageContainer` which will be filled with
        /// the result of this containers encoding.
        ///
        /// - Parameters:
        ///     - codingPath:   The path of coding keys taken to get to this point in encoding.
        ///     - rootStorage:  The rootStorage container for storing the results from this containers encoding.
        ///
        init(codingPath: [CodingKey], rootStorage: UnkeyedStorageContainer) {
            self.rootStorage = rootStorage
            self.codingPath = codingPath
        }

        // MARK: - `UnkeyedEncodingContainer` conformance

        var count: Int { return rootStorage.count }

        var codingPath: [CodingKey]

        mutating func encodeNil() throws { self.rootStorage.push(NullStorageContainer.null) }

        ///
        /// All encode types accept encodeNil can throw the following.
        //
        /// - throws: `EncodingError.invalidValue` if the given value is invalid in the current context for this format.
        ///
        mutating func encode(_ value: Bool)   throws { self.rootStorage.push(SingleValueContainer(value)) }
        mutating func encode(_ value: Int)    throws { self.rootStorage.push(SingleValueContainer(value)) }
        mutating func encode(_ value: Int8)   throws { self.rootStorage.push(SingleValueContainer(value)) }
        mutating func encode(_ value: Int16)  throws { self.rootStorage.push(SingleValueContainer(value)) }
        mutating func encode(_ value: Int32)  throws { self.rootStorage.push(SingleValueContainer(value)) }
        mutating func encode(_ value: Int64)  throws { self.rootStorage.push(SingleValueContainer(value)) }
        mutating func encode(_ value: UInt)   throws { self.rootStorage.push(SingleValueContainer(value)) }
        mutating func encode(_ value: UInt8)  throws { self.rootStorage.push(SingleValueContainer(value)) }
        mutating func encode(_ value: UInt16) throws { self.rootStorage.push(SingleValueContainer(value)) }
        mutating func encode(_ value: UInt32) throws { self.rootStorage.push(SingleValueContainer(value)) }
        mutating func encode(_ value: UInt64) throws { self.rootStorage.push(SingleValueContainer(value)) }
        mutating func encode(_ value: Float)  throws { self.rootStorage.push(SingleValueContainer(value)) }
        mutating func encode(_ value: Double) throws { self.rootStorage.push(SingleValueContainer(value)) }
        mutating func encode(_ value: String) throws { self.rootStorage.push(SingleValueContainer(value)) }

        ///
        /// - throws: `EncodingError.invalidValue` if the given value is invalid in the current context for this format.
        ///
        mutating func encode<T: Encodable>(_ value: T) throws {
            let encoder = _BinaryEncoder(codingPath: self.codingPath, rootStorage: self.rootStorage.pushReference())
            try value.encode(to: encoder)
        }

        mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
            let storage = KeyedStorageContainer()
            self.rootStorage.push(storage)

            return KeyedEncodingContainer(_BinaryKeyedEncodingContainer(codingPath: self.codingPath, rootStorage: storage))
        }

        mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
            let storage = UnkeyedStorageContainer()
            self.rootStorage.push(storage)

            return _BinaryUnkeyedEncodingContainer(codingPath: self.codingPath, rootStorage: storage)
        }

        mutating func superEncoder() -> Encoder {
            return _BinaryEncoder(codingPath: self.codingPath, rootStorage: self.rootStorage.pushReference())
        }

        // MARK: - Private methods and storage

        private var rootStorage: UnkeyedStorageContainer
    }

    // MARK: -

    ///
    ///  Encoding container which encodes single primitive type values to storage.
    ///
    private struct _BinarySingleValueEncodingContainer: SingleValueEncodingContainer {

        // MARK: - Initialization

        ///
        /// Init with the current codingPath and a `StorageContainerReference` which will be filled with
        /// the result of this containers encoding.
        ///
        /// - Parameters:
        ///     - codingPath:   The path of coding keys taken to get to this point in encoding.
        ///     - rootStorage:  The `StorageContainerReference` for storing the results from this containers encoding.
        ///
        init(codingPath: [CodingKey], rootStorage: StorageContainerReference) {
            self.rootStorage = rootStorage
            self.codingPath = codingPath
        }

        // MARK: - `SingleValueEncodingContainer` conformance

        var codingPath: [CodingKey]

        mutating func encodeNil() throws { self.rootStorage.value = NullStorageContainer.null }
        
        ///
        /// All encode types accept encodeNil can throw the following.
        //
        /// - throws: `EncodingError.invalidValue` if the given value is invalid in the current context for this format.
        ///
        mutating func encode(_ value: Bool)   throws { self.rootStorage.value = SingleValueContainer(value) }
        mutating func encode(_ value: Int)    throws { self.rootStorage.value = SingleValueContainer(value) }
        mutating func encode(_ value: Int8)   throws { self.rootStorage.value = SingleValueContainer(value) }
        mutating func encode(_ value: Int16)  throws { self.rootStorage.value = SingleValueContainer(value) }
        mutating func encode(_ value: Int32)  throws { self.rootStorage.value = SingleValueContainer(value) }
        mutating func encode(_ value: Int64)  throws { self.rootStorage.value = SingleValueContainer(value) }
        mutating func encode(_ value: UInt)   throws { self.rootStorage.value = SingleValueContainer(value) }
        mutating func encode(_ value: UInt8)  throws { self.rootStorage.value = SingleValueContainer(value) }
        mutating func encode(_ value: UInt16) throws { self.rootStorage.value = SingleValueContainer(value) }
        mutating func encode(_ value: UInt32) throws { self.rootStorage.value = SingleValueContainer(value) }
        mutating func encode(_ value: UInt64) throws { self.rootStorage.value = SingleValueContainer(value) }
        mutating func encode(_ value: Float)  throws { self.rootStorage.value = SingleValueContainer(value) }
        mutating func encode(_ value: Double) throws { self.rootStorage.value = SingleValueContainer(value) }
        mutating func encode(_ value: String) throws { self.rootStorage.value = SingleValueContainer(value) }

        ///
        /// Encode an object type value.
        ///
        mutating func encode<T: Encodable>(_ value: T) throws {
            ///
            /// Object values are a special case here.  We can't encode them in a primitive Single value container
            /// as they are not meant to support that type.
            ///
            /// Instead we create a new _BinaryEncoder and pass the storage reference up to that encoder
            /// which will then fill the reference with the appropriate type of storage for the type.
            ///
            let encoder = _BinaryEncoder(codingPath: self.codingPath, rootStorage: self.rootStorage)
            try value.encode(to: encoder)
        }

        // MARK: - Private methods and storage

        ///
        /// The root storage of our container is a reference because we are called
        /// from a previous level which does not know the type of container that
        /// will be stored at its current location.
        ///
        private var rootStorage: StorageContainerReference
    }
}
