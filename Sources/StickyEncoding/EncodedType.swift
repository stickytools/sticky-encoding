///
///  EncodedType.swift
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
///  Created by Tony Stone on 10/15/17.
///
import Swift

///
/// Type used to store the encoded type of the data stored in binary (or other forms).
///
/// This type is fixed to Int32 to restrict it's binary storage size.
///
internal struct EncodedType: Equatable {
    static let bool   = EncodedType(0xa1)
    static let int    = EncodedType(0xa2)
    static let int8   = EncodedType(0xa3)
    static let int16  = EncodedType(0xa4)
    static let int32  = EncodedType(0xa5)
    static let int64  = EncodedType(0xa6)
    static let uint   = EncodedType(0xa7)
    static let uint8  = EncodedType(0xa8)
    static let uint16 = EncodedType(0xa9)
    static let uint32 = EncodedType(0xaa)
    static let uint64 = EncodedType(0xab)
    static let float  = EncodedType(0xac)
    static let double = EncodedType(0xad)
    static let string = EncodedType(0xb0)
    
    static func == (lhs: EncodedType, rhs: EncodedType) -> Bool {
        return lhs.value == rhs.value
    }

    internal /* @testable */
    init(_ value: Int) {
        self.value = Int32(value)
    }
    private let value: Int32
}


///
/// `CustomStringConvertible` and `CustomDebugStringConvertible` conformance.
///
extension EncodedType: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        switch self {
        case .bool:    return "Bool"
        case .int:     return "Int"
        case .int8:    return "Int8"
        case .int16:   return "Int16"
        case .int32:   return "Int32"
        case .int64:   return "Int64"
        case .uint:    return "UInt"
        case .uint8:   return "UInt8"
        case .uint16:  return "UInt16"
        case .uint32:  return "UInt32"
        case .uint64:  return "UInt64"
        case .float:   return "Float"
        case .double:  return "Double"
        case .string:  return "String"
        default:
            return "Unknown"
        }
    }
    public var debugDescription: String {
        return description
    }
}
///
/// Protocol defining a static method to gain access to a types encoded type.
///
internal protocol EncodableType {
    static var encodedType: EncodedType { get }
}

// MARK: - Types implementing `EncodableType`
extension Bool: EncodableType {
    static var encodedType: EncodedType { return .bool }
}
extension Int: EncodableType {
    static var encodedType: EncodedType { return .int }
}
extension Int8: EncodableType {
    static var encodedType: EncodedType { return .int8 }
}
extension Int16: EncodableType {
    static var encodedType: EncodedType { return .int16 }
}
extension Int32: EncodableType {
    static var encodedType: EncodedType { return .int32 }
}
extension Int64: EncodableType {
    static var encodedType: EncodedType { return .int64 }
}
extension UInt: EncodableType {
    static var encodedType: EncodedType { return .uint }
}
extension UInt8: EncodableType {
    static var encodedType: EncodedType { return .uint8 }
}
extension UInt16: EncodableType {
    static var encodedType: EncodedType { return .uint16 }
}
extension UInt32: EncodableType {
    static var encodedType: EncodedType { return .uint32 }
}
extension UInt64: EncodableType {
    static var encodedType: EncodedType { return .uint64 }
}
extension Float: EncodableType {
    static var encodedType: EncodedType { return .float }
}
extension Double: EncodableType {
    static var encodedType: EncodedType { return .double }
}
extension String: EncodableType {
    static var encodedType: EncodedType { return .string }
}
