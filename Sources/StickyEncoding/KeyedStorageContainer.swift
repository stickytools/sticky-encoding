///
///  KeyedStorageContainer.swift
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
/// A type representing keyed storage implementing the `StorageContainer` interface.
///
/// This type allows simple subscript access to its contents.
///
internal class KeyedStorageContainer: StorageContainer {

    typealias Key     = String
    typealias Value   = StorageContainer
    typealias Element = (key: Key, value: Value)

    ///
    /// Initialize `self`.
    ///
    init() {
        self.storage = [:]
    }

    var count: Int {
        return self.storage.count
    }

    ///
    /// Returns all the keys contained in the `StorageContainer`.
    ///
    var keys: [Key] {
        return self.storage.keys.flatMap { $0 }
    }

    ///
    /// Returns whether a value for the key is contained in the `StorageContainer`.
    ///
    func contains(_ key: Key) -> Bool {
        return self.storage[key] != nil
    }

    ///
    /// Accesses the value with the given key for reading and writing.
    ///
    subscript(key: Key) -> Value? {
        get { return self.storage[key] }
        set { self.storage[key] = newValue }
    }

    private var storage: [Key: Value]
}

///
/// `Sequence` conformance.
///
extension KeyedStorageContainer: Sequence {

    typealias Iterator  = Dictionary<Key,Value>.Iterator

    func makeIterator() -> KeyedStorageContainer.Iterator {
        return self.storage.makeIterator()
    }
}

///
/// `CustomStringConvertible` and `CustomDebugStringConvertible` conformance.
///
extension KeyedStorageContainer: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        let elements = self.storage.map { "\(String(describing: $0.key)): \(String(describing: $0.value))" }
        return "[\(elements.joined(separator: ", "))]"
    }
    public var debugDescription: String {
        let elements = self.storage.map { "\(String(reflecting: $0.key)): \(String(reflecting: $0.value))" }
        return "[\(elements.joined(separator: ", "))]"
    }
}


///
/// Extension to support `StorageContainerReference` references.
///
extension KeyedStorageContainer {

    ///
    /// Returns a `StorageContainerReference` to `self` for the given key.
    ///
    func elementReference(for key: Key) -> StorageContainerReference {
        return ElementReference(self, forKey: key)
    }

    ///
    /// Inner class implementation of a `StorageContainerReference` for references to `self`.
    ///
    private class ElementReference: StorageContainerReference, CustomStringConvertible, CustomDebugStringConvertible {
        private var container: KeyedStorageContainer
        private var key: Key
        init(_ container: KeyedStorageContainer, forKey key: Key) {
            self.container = container
            self.key = key
        }
        var value: StorageContainer? {
            get { return container[key] }
            set { container[key] = newValue }
        }
        public var description: String {
            guard let value = container[key]
                else { return "nil" }
            return String(describing: value)
        }
        public var debugDescription: String {
            guard let value = container[key]
                else { return "nil" }
            return String(reflecting: value)
        }
    }
}
