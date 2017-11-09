///
///  UnkeyedStorageContainer.swift
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
/// A type representing unkeyed storage implementing the `StorageContainer` interface.
///
/// This type allows simple additions through `push` and random access via subscripts.
///
internal class UnkeyedStorageContainer: StorageContainer {

    typealias Element = StorageContainer

    ///
    /// Initialize `self`.
    ///
    init() {
        self.storage = []
    }

    ///
    /// Returns the count of `StorageContainers` in this container.
    ///
    var count: Int {
        return self.storage.count
    }

    ///
    /// Push a `StorageContainer` onto the stack.
    ///
    func push(_ storageContainer: Element) {
        self.storage.append(storageContainer)
    }

    ///
    /// Accesses the value with the given key for reading and writing.
    ///
    subscript(index: Int) -> Element {
        @inline(__always)
        get {
            precondition(index < self.storage.count, "Index out of range.")
            return self.storage[index]
        }
        @inline(__always)
        set {
            precondition(index < self.storage.count, "Index out of range.")
            self.storage[index] = newValue
        }
    }

    private var storage: [Element]
}

///
/// `CustomStringConvertible` and `CustomDebugStringConvertible` conformance.
///
extension UnkeyedStorageContainer: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        let elements = self.storage.map { String(describing: $0) }
        return "[\(elements.joined(separator: ", "))]"
    }
    public var debugDescription: String {
        let elements = self.storage.map { String(reflecting: $0) }
        return "[\(elements.joined(separator: ", "))]"
    }
}

///
/// Extension to support `StorageContainerReference` references.
///
extension UnkeyedStorageContainer {

    ///
    /// Push `NullStorageContainer.null` onto the stack and return a `StorageContainerReference` to the location.
    ///
    /// - Returns: A `StorageContainerReference` instance to the newly added location.
    ///
    func pushReference() -> StorageContainerReference {
        self.push(NullStorageContainer.null)
        return ElementReference(self, at: self.count - 1)
    }

    ///
    /// Inner class implementation of a `StorageContainerReference` for references to `self`.
    ///
    private class ElementReference: StorageContainerReference, CustomStringConvertible, CustomDebugStringConvertible {
        private var container: UnkeyedStorageContainer
        private var index: Int
        init(_ container: UnkeyedStorageContainer, at index: Int) {
            self.container = container
            self.index = index
        }
        var value: StorageContainer? {
            get { return container[index] }
            set {
                if let newValue = newValue {
                    container[index] = newValue
                }
            }
        }
        public var description: String { return String(describing: container[index]) }
        public var debugDescription: String { return String(reflecting: container[index]) }
    }
}
