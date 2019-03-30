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

// MARK: Encoders & Decoders

/// ## Overview
///
/// `BinaryEncoder` facilitates the encoding of `Encodable` values into a binary
/// format that can be stored on disk or sent over a socket.
///
/// The encoder will encode any `Encodable` type whether you declare conformance to
/// `Encodable` and let the compiler create the code or you manually implement the
/// conformance yourself.
///
/// ### Examples
///
/// To create an instance of a BinaryEncoder:
/// ```
///     let encoder = BinaryEncoder()
/// ```
///
/// > Note: You may optionally pass your own userInfo `BinaryEncoder(userInfo:)` structure and it will be available to you during the encoding process.
///
/// You can encode any top even top-level single value types including Int,
/// UInt, Double, Bool, and Strings. Simply pass the value to the instance
/// of the BinaryEncoder and call `encode`.
/// ```
///    let string = "You can encode single values of any type."
///
///    let encoded = try encoder.encode(string)
/// ```
/// Basic structs and classes can also be encoded.
/// ```
///    struct Employee: Codable {
///         let first: String
///         let last: String
///         let employeeNumber: Int
///    }
///
///    let employee = Employee(first: "John", last: "Doe", employeeNumber: 2345643)
///
///    let encodedData = try encoder.encode(employee)
/// ```
/// As well as Complex types with sub classes.
///
open class BinaryEncoder {

    // MARK: Initialization

    /// Initializes an instance of the encoder optionally passing context information for the encoding process.
    ///
    /// - Parameter userInfo: Any contextual information set by the user for encoding.
    ///
    public init(userInfo: [CodingUserInfoKey : Any] = [:]) {
        self.userInfo = userInfo
    }

    // MARK: Encoding objects into binary

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
        let encoder = _BinaryEncoder(codingPath: [], userInfo: self.userInfo)
        try value.encode(to: encoder)

        if let storage = encoder.rootStorage.value {
            return EncodedData(storage)
        }
        return EncodedData(NullStorageContainer.null)
    }

    // MARK: Getting contextual information

    /// Any contextual information set by the user for encoding.
    ///
    public var userInfo: [CodingUserInfoKey : Any]
}

// MARK: -

/// Main Encoder class
///
private class _BinaryEncoder : Encoder {

    // MARK: - Initialization

    /// Init with the current codingPath and a default `PassthroughReference` (local storage) which will be filled with
    /// the result of this containers encoding.
    ///
    /// - Parameters:
    ///     - codingPath:   The path of coding keys taken to get to this point in encoding.
    ///
    init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.rootStorage = PassthroughReference()
        self.codingPath  = codingPath
        self.userInfo    = userInfo
    }

    /// Init with the current codingPath and a `StorageContainerReference` which will be filled with
    /// the result of this containers encoding.
    ///
    /// - Parameters:
    ///     - codingPath:   The path of coding keys taken to get to this point in encoding.
    ///     - rootStorage:  The rootStorage container for storing the results from this containers encoding.  This is a reference element that will be filled by this class.
    ///
    init(codingPath: [CodingKey], rootStorage: StorageContainerReference, userInfo: [CodingUserInfoKey : Any]) {
        self.rootStorage = rootStorage
        self.codingPath  = codingPath
        self.userInfo    = userInfo
    }

    // MARK: - `Encoder` conformance.

    /// The path of coding keys taken to get to this point in encoding.
    ///
    /// - Note: At this point this should be empty
    ///
    public var codingPath: [CodingKey]

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

        return KeyedEncodingContainer(_BinaryKeyedEncodingContainer<Key>(referencing: self, codingPath: codingPath, rootStorage: storageContainer))
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        let storageContainer: UnkeyedStorageContainer

        if let container = self.rootStorage.value as? UnkeyedStorageContainer {
            storageContainer = container
        } else {
            storageContainer = UnkeyedStorageContainer()
            self.rootStorage.value = storageContainer
        }
        return _BinaryUnkeyedEncodingContainer(referencing: self, codingPath: codingPath, rootStorage: storageContainer)
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        return _BinarySingleValueEncodingContainer(referencing: self, codingPath: codingPath, rootStorage: self.rootStorage)
    }

    /// For each instance of the encoder, there is only one
    /// root storage container which can be a `SingleValueContainer`,
    /// a `UnkeyedStorageContainer`, or a `KeyStorageContainer`.
    ///
    var rootStorage: StorageContainerReference
}

// MARK: - Containers

/// Encoding containers used by `_BinaryEncoder`.
///
extension _BinaryEncoder {

    // MARK: -

    ///  Encoding container which encodes values into an keyed (Dictionary type) container.
    ///
    private struct _BinaryKeyedEncodingContainer<K : CodingKey>: KeyedEncodingContainerProtocol  {

        // MARK: - Initialization

        /// Init with the current codingPath and a `KeyedStorageContainer` which will be filled with
        /// the result of this containers encoding.
        ///
        /// - Parameters:
        ///     - codingPath:   The path of coding keys taken to get to this point in encoding.
        ///     - rootStorage:  The rootStorage container for storing the results from this containers encoding.
        ///
        init(referencing encoder: _BinaryEncoder, codingPath: [CodingKey], rootStorage: KeyedStorageContainer) {
            self.encoder     = encoder
            self.rootStorage = rootStorage
            self.codingPath  = codingPath
        }

        // MARK: - `KeyedEncodingContainerProtocol` conformance

        /// The path of coding keys taken to get to this point in encoding.
        var codingPath: [CodingKey]

        mutating func encodeNil(forKey key: K) throws { self.rootStorage[key.stringValue] = NullStorageContainer.null }

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

        /// - throws: `EncodingError.invalidValue` if the given value is invalid in the current context for this format.
        ///
        mutating func encode<T: Encodable>(_ value: T, forKey key: K) throws {
            let encoder = _BinaryEncoder(codingPath: self.codingPath + key, rootStorage: self.rootStorage.elementReference(for: key.stringValue), userInfo: self.encoder.userInfo)
            try value.encode(to: encoder)
        }

        mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: K) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
            let storage = KeyedStorageContainer()
            self.rootStorage[key.stringValue] = storage

            return KeyedEncodingContainer(_BinaryKeyedEncodingContainer<NestedKey>(referencing: self.encoder, codingPath: self.codingPath + key, rootStorage: storage))
        }

        mutating func nestedUnkeyedContainer(forKey key: K) -> UnkeyedEncodingContainer {
            let storage = UnkeyedStorageContainer()
            self.rootStorage[key.stringValue] = storage

            return _BinaryUnkeyedEncodingContainer(referencing: self.encoder, codingPath: self.codingPath + key, rootStorage: storage)
        }

        mutating func superEncoder(forKey key: K) -> Encoder {
            return _BinaryEncoder(codingPath: self.codingPath + key, rootStorage: self.rootStorage.elementReference(for: key.stringValue), userInfo: self.encoder.userInfo)
        }

        mutating func superEncoder() -> Encoder {
            return _BinaryEncoder(codingPath: self.codingPath, rootStorage: self.rootStorage.elementReference(for: "super"), userInfo: self.encoder.userInfo)
        }

        // MARK: - Private methods and storage.

        /// The encoder this container was created from.
        ///
        private let encoder: _BinaryEncoder

        /// The root storage for this container.
        ///
        private var rootStorage: KeyedStorageContainer
    }

    // MARK: -

    ///  Encoding container which encodes values into an unkeyed (Array type) container.
    ///
    private struct _BinaryUnkeyedEncodingContainer: UnkeyedEncodingContainer {

        // MARK: - Initialization

        /// Init with the current codingPath and an `UnkeyedStorageContainer` which will be filled with
        /// the result of this containers encoding.
        ///
        /// - Parameters:
        ///     - codingPath:   The path of coding keys taken to get to this point in encoding.
        ///     - rootStorage:  The rootStorage container for storing the results from this containers encoding.
        ///
        init(referencing encoder: _BinaryEncoder, codingPath: [CodingKey], rootStorage: UnkeyedStorageContainer) {
            self.encoder     = encoder
            self.rootStorage = rootStorage
            self.codingPath  = codingPath
        }

        // MARK: - `UnkeyedEncodingContainer` conformance

        var count: Int { return rootStorage.count }

        var codingPath: [CodingKey]

        mutating func encodeNil() throws { self.rootStorage.push(NullStorageContainer.null) }

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
            let encoder = _BinaryEncoder(codingPath: self.codingPath, rootStorage: self.rootStorage.pushReference(), userInfo: self.encoder.userInfo)
            try value.encode(to: encoder)
        }

        mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
            let storage = KeyedStorageContainer()
            self.rootStorage.push(storage)

            return KeyedEncodingContainer(_BinaryKeyedEncodingContainer(referencing: self.encoder, codingPath: self.codingPath, rootStorage: storage))
        }

        mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
            let storage = UnkeyedStorageContainer()
            self.rootStorage.push(storage)

            return _BinaryUnkeyedEncodingContainer(referencing: self.encoder, codingPath: self.codingPath, rootStorage: storage)
        }

        mutating func superEncoder() -> Encoder {
            return _BinaryEncoder(codingPath: self.codingPath, rootStorage: self.rootStorage.pushReference(), userInfo: self.encoder.userInfo)
        }

        // MARK: - Private methods and storage

        /// The encoder this container was created from.
        ///
        private let encoder: _BinaryEncoder

        /// The root storage for this container.
        ///
        private var rootStorage: UnkeyedStorageContainer
    }

    // MARK: -

    ///  Encoding container which encodes single primitive type values to storage.
    ///
    private struct _BinarySingleValueEncodingContainer: SingleValueEncodingContainer {

        // MARK: - Initialization

        /// Init with the current codingPath and a `StorageContainerReference` which will be filled with
        /// the result of this containers encoding.
        ///
        /// - Parameters:
        ///     - codingPath:   The path of coding keys taken to get to this point in encoding.
        ///     - rootStorage:  The `StorageContainerReference` for storing the results from this containers encoding.
        ///
        init(referencing encoder: _BinaryEncoder, codingPath: [CodingKey], rootStorage: StorageContainerReference) {
            self.encoder     = encoder
            self.rootStorage = rootStorage
            self.codingPath  = codingPath
        }

        // MARK: - `SingleValueEncodingContainer` conformance

        var codingPath: [CodingKey]

        mutating func encodeNil() throws { self.rootStorage.value = NullStorageContainer.null }

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

        /// Encode an object type value.
        ///
        mutating func encode<T: Encodable>(_ value: T) throws {

            /// Object values are a special case here.  We can't encode them in a primitive Single value container
            /// as they are not meant to support that type.
            ///
            /// Instead we create a new _BinaryEncoder and pass the storage reference up to that encoder
            /// which will then fill the reference with the appropriate type of storage for the type.
            ///
            try value.encode(to: _BinaryEncoder(codingPath: self.codingPath, rootStorage: rootStorage, userInfo: self.encoder.userInfo))
        }

        // MARK: - Private methods and storage


        /// The encoder this container was created from.
        ///
        private let encoder: _BinaryEncoder

        /// The root storage of our container is a reference because we are called
        /// from a previous level which does not know the type of container that
        /// will be stored at its current location.
        ///
        private var rootStorage: StorageContainerReference
    }
}
