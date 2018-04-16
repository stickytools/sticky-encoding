
/// build-tools: auto-generated

#if os(Linux) || os(FreeBSD)

import XCTest

@testable import StickyEncodingTests

XCTMain([
   testCase(KeyedStorageContainerTests.allTests),
   testCase(KeyedStorageContainerElementReferenceTests.allTests),
   testCase(BinaryEncodingKeyedContainerNegativeTests.allTests),
   testCase(BinaryEncodingUnkeyedContainerNegativeTests.allTests),
   testCase(UnkeyedStorageContainerTests.allTests),
   testCase(UnkeyedStorageContainerElementReferenceTests.allTests),
   testCase(BinaryEncodingStructuredTypeTests.allTests),
   testCase(EncodedTypeTests.allTests),
   testCase(EncodedTypePerformanceTests.allTests),
   testCase(StorageContainerReferenceTests.allTests),
   testCase(PassthroughReferenceTests.allTests),
   testCase(BinaryEncodingUnkeyedContainerTests.allTests),
   testCase(BinaryEncodingKeyedContainerTests.allTests),
   testCase(StorageContainerTests.allTests),
   testCase(NullStorageContainerTests.allTests),
   testCase(BinaryCodingKeyTests.allTests),
   testCase(BinaryEncoderUserObjectNegativeTests.allTests),
   testCase(SingleValueContainerTests.allTests),
   testCase(SingleValueContainerPerformanceTests.allTests),
   testCase(DecodingError_ExtensionsTests.allTests),
   testCase(BinaryEncodingSingleValueContainerTests.allTests),
   testCase(EncodedDataTests.allTests),
   testCase(BinaryEncodingSingleValueContainerNegativeTests.allTests),
   testCase(StorageContainerEqualTests.allTests),
   testCase(BinaryDecoderNegativeTests.allTests),
   testCase(StorageContainerReaderWriterTests.allTests)
])

extension KeyedStorageContainerTests {
   static var allTests: [(String, (KeyedStorageContainerTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testKeys", testKeys),
                ("testContains", testContains),
                ("testSubscript", testSubscript),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testDescriptionWithValues", testDescriptionWithValues),
                ("testDebugDescriptionWithValues", testDebugDescriptionWithValues)
           ]
   }
}

extension KeyedStorageContainerElementReferenceTests {
   static var allTests: [(String, (KeyedStorageContainerElementReferenceTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testDescriptionWithValue", testDescriptionWithValue),
                ("testDebugDescriptionWithValue", testDebugDescriptionWithValue)
           ]
   }
}

extension BinaryEncodingKeyedContainerNegativeTests {
   static var allTests: [(String, (BinaryEncodingKeyedContainerNegativeTests) -> () throws -> Void)] {
      return [
                ("testDecodeNilWhenKeyNotFound", testDecodeNilWhenKeyNotFound),
                ("testDecodeBoolWhenKeyNotFound", testDecodeBoolWhenKeyNotFound),
                ("testDecodeBoolWhenTypeMismatch", testDecodeBoolWhenTypeMismatch),
                ("testDecodeBoolWhenValueNotFound", testDecodeBoolWhenValueNotFound),
                ("testDecodeBoolWhenIncorrectContainerType", testDecodeBoolWhenIncorrectContainerType),
                ("testDecodeIntWhenKeyNotFound", testDecodeIntWhenKeyNotFound),
                ("testDecodeIntWhenTypeMismatch", testDecodeIntWhenTypeMismatch),
                ("testDecodeIntWhenValueNotFound", testDecodeIntWhenValueNotFound),
                ("testDecodeIntWhenIncorrectContainerType", testDecodeIntWhenIncorrectContainerType),
                ("testDecodeInt8WhenKeyNotFound", testDecodeInt8WhenKeyNotFound),
                ("testDecodeInt8WhenTypeMismatch", testDecodeInt8WhenTypeMismatch),
                ("testDecodeInt8WhenValueNotFound", testDecodeInt8WhenValueNotFound),
                ("testDecodeInt8WhenIncorrectContainerType", testDecodeInt8WhenIncorrectContainerType),
                ("testDecodeInt16WhenKeyNotFound", testDecodeInt16WhenKeyNotFound),
                ("testDecodeInt16WhenTypeMismatch", testDecodeInt16WhenTypeMismatch),
                ("testDecodeInt16WhenValueNotFound", testDecodeInt16WhenValueNotFound),
                ("testDecodeInt16WhenIncorrectContainerType", testDecodeInt16WhenIncorrectContainerType),
                ("testDecodeInt32WhenKeyNotFound", testDecodeInt32WhenKeyNotFound),
                ("testDecodeInt32WhenTypeMismatch", testDecodeInt32WhenTypeMismatch),
                ("testDecodeInt32WhenValueNotFound", testDecodeInt32WhenValueNotFound),
                ("testDecodeInt32WhenIncorrectContainerType", testDecodeInt32WhenIncorrectContainerType),
                ("testDecodeInt64WhenKeyNotFound", testDecodeInt64WhenKeyNotFound),
                ("testDecodeInt64WhenTypeMismatch", testDecodeInt64WhenTypeMismatch),
                ("testDecodeInt64WhenValueNotFound", testDecodeInt64WhenValueNotFound),
                ("testDecodeInt64WhenIncorrectContainerType", testDecodeInt64WhenIncorrectContainerType),
                ("testDecodeUIntWhenKeyNotFound", testDecodeUIntWhenKeyNotFound),
                ("testDecodeUIntWhenTypeMismatch", testDecodeUIntWhenTypeMismatch),
                ("testDecodeUIntWhenValueNotFound", testDecodeUIntWhenValueNotFound),
                ("testDecodeUIntWhenIncorrectContainerType", testDecodeUIntWhenIncorrectContainerType),
                ("testDecodeUInt8WhenKeyNotFound", testDecodeUInt8WhenKeyNotFound),
                ("testDecodeUInt8WhenTypeMismatch", testDecodeUInt8WhenTypeMismatch),
                ("testDecodeUInt8WhenValueNotFound", testDecodeUInt8WhenValueNotFound),
                ("testDecodeUInt8WhenIncorrectContainerType", testDecodeUInt8WhenIncorrectContainerType),
                ("testDecodeUInt16WhenKeyNotFound", testDecodeUInt16WhenKeyNotFound),
                ("testDecodeUInt16WhenTypeMismatch", testDecodeUInt16WhenTypeMismatch),
                ("testDecodeUInt16WhenValueNotFound", testDecodeUInt16WhenValueNotFound),
                ("testDecodeUInt16WhenIncorrectContainerType", testDecodeUInt16WhenIncorrectContainerType),
                ("testDecodeUInt32WhenKeyNotFound", testDecodeUInt32WhenKeyNotFound),
                ("testDecodeUInt32WhenTypeMismatch", testDecodeUInt32WhenTypeMismatch),
                ("testDecodeUInt32WhenValueNotFound", testDecodeUInt32WhenValueNotFound),
                ("testDecodeUInt32WhenIncorrectContainerType", testDecodeUInt32WhenIncorrectContainerType),
                ("testDecodeUInt64WhenKeyNotFound", testDecodeUInt64WhenKeyNotFound),
                ("testDecodeUInt64WhenTypeMismatch", testDecodeUInt64WhenTypeMismatch),
                ("testDecodeUInt64WhenValueNotFound", testDecodeUInt64WhenValueNotFound),
                ("testDecodeUInt64WhenIncorrectContainerType", testDecodeUInt64WhenIncorrectContainerType),
                ("testDecodeFloatWhenKeyNotFound", testDecodeFloatWhenKeyNotFound),
                ("testDecodeFloatWhenTypeMismatch", testDecodeFloatWhenTypeMismatch),
                ("testDecodeFloatWhenValueNotFound", testDecodeFloatWhenValueNotFound),
                ("testDecodeFloatWhenIncorrectContainerType", testDecodeFloatWhenIncorrectContainerType),
                ("testDecodeDoubleWhenKeyNotFound", testDecodeDoubleWhenKeyNotFound),
                ("testDecodeDoubleWhenTypeMismatch", testDecodeDoubleWhenTypeMismatch),
                ("testDecodeDoubleWhenValueNotFound", testDecodeDoubleWhenValueNotFound),
                ("testDecodeDoubleWhenIncorrectContainerType", testDecodeDoubleWhenIncorrectContainerType),
                ("testDecodeStringWhenKeyNotFound", testDecodeStringWhenKeyNotFound),
                ("testDecodeStringWhenTypeMismatch", testDecodeStringWhenTypeMismatch),
                ("testDecodeStringWhenValueNotFound", testDecodeStringWhenValueNotFound),
                ("testDecodeStringWhenIncorrectContainerType", testDecodeStringWhenIncorrectContainerType),
                ("testDecodeCodableTypeWhenKeyNotFound", testDecodeCodableTypeWhenKeyNotFound),
                ("testDecodeCodableTypeWhenTypeMismatch", testDecodeCodableTypeWhenTypeMismatch),
                ("testDecodeCodableTypeWhenValueNotFound", testDecodeCodableTypeWhenValueNotFound),
                ("testDecodeCodableTypeWhenIncorrectContainerType", testDecodeCodableTypeWhenIncorrectContainerType)
           ]
   }
}

extension BinaryEncodingUnkeyedContainerNegativeTests {
   static var allTests: [(String, (BinaryEncodingUnkeyedContainerNegativeTests) -> () throws -> Void)] {
      return [
                ("testDecodeBoolValueNotFoundWhenValueIsNil", testDecodeBoolValueNotFoundWhenValueIsNil),
                ("testDecodeBoolValueNotFoundWhenContainerIsNil", testDecodeBoolValueNotFoundWhenContainerIsNil),
                ("testDecodeBoolValueNotFoundWhenNoMoreValues", testDecodeBoolValueNotFoundWhenNoMoreValues),
                ("testDecodeBoolTypeMismatchWhenValueNotConvertable", testDecodeBoolTypeMismatchWhenValueNotConvertable),
                ("testDecodeBoolTypeMismatchWhenValueNotCorrectContainerType", testDecodeBoolTypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeIntValueNotFoundWhenValueIsNil", testDecodeIntValueNotFoundWhenValueIsNil),
                ("testDecodeIntValueNotFoundWhenContainerIsNil", testDecodeIntValueNotFoundWhenContainerIsNil),
                ("testDecodeIntValueNotFoundWhenNoMoreValues", testDecodeIntValueNotFoundWhenNoMoreValues),
                ("testDecodeIntTypeMismatchWhenValueNotConvertable", testDecodeIntTypeMismatchWhenValueNotConvertable),
                ("testDecodeIntTypeMismatchWhenValueNotCorrectContainerType", testDecodeIntTypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeInt8ValueNotFoundWhenValueIsNil", testDecodeInt8ValueNotFoundWhenValueIsNil),
                ("testDecodeInt8ValueNotFoundWhenContainerIsNil", testDecodeInt8ValueNotFoundWhenContainerIsNil),
                ("testDecodeInt8ValueNotFoundWhenNoMoreValues", testDecodeInt8ValueNotFoundWhenNoMoreValues),
                ("testDecodeInt8TypeMismatchWhenValueNotConvertable", testDecodeInt8TypeMismatchWhenValueNotConvertable),
                ("testDecodeInt8TypeMismatchWhenValueNotCorrectContainerType", testDecodeInt8TypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeInt16ValueNotFoundWhenValueIsNil", testDecodeInt16ValueNotFoundWhenValueIsNil),
                ("testDecodeInt16ValueNotFoundWhenContainerIsNil", testDecodeInt16ValueNotFoundWhenContainerIsNil),
                ("testDecodeInt16ValueNotFoundWhenNoMoreValues", testDecodeInt16ValueNotFoundWhenNoMoreValues),
                ("testDecodeInt16TypeMismatchWhenValueNotConvertable", testDecodeInt16TypeMismatchWhenValueNotConvertable),
                ("testDecodeInt16TypeMismatchWhenValueNotCorrectContainerType", testDecodeInt16TypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeInt32ValueNotFoundWhenValueIsNil", testDecodeInt32ValueNotFoundWhenValueIsNil),
                ("testDecodeInt32ValueNotFoundWhenContainerIsNil", testDecodeInt32ValueNotFoundWhenContainerIsNil),
                ("testDecodeInt32ValueNotFoundWhenNoMoreValues", testDecodeInt32ValueNotFoundWhenNoMoreValues),
                ("testDecodeInt32TypeMismatchWhenValueNotConvertable", testDecodeInt32TypeMismatchWhenValueNotConvertable),
                ("testDecodeInt32TypeMismatchWhenValueNotCorrectContainerType", testDecodeInt32TypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeInt64ValueNotFoundWhenValueIsNil", testDecodeInt64ValueNotFoundWhenValueIsNil),
                ("testDecodeInt64ValueNotFoundWhenContainerIsNil", testDecodeInt64ValueNotFoundWhenContainerIsNil),
                ("testDecodeInt64ValueNotFoundWhenNoMoreValues", testDecodeInt64ValueNotFoundWhenNoMoreValues),
                ("testDecodeInt64TypeMismatchWhenValueNotConvertable", testDecodeInt64TypeMismatchWhenValueNotConvertable),
                ("testDecodeInt64TypeMismatchWhenValueNotCorrectContainerType", testDecodeInt64TypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeUIntValueNotFoundWhenValueIsNil", testDecodeUIntValueNotFoundWhenValueIsNil),
                ("testDecodeUIntValueNotFoundWhenContainerIsNil", testDecodeUIntValueNotFoundWhenContainerIsNil),
                ("testDecodeUIntValueNotFoundWhenNoMoreValues", testDecodeUIntValueNotFoundWhenNoMoreValues),
                ("testDecodeUIntTypeMismatchWhenValueNotConvertable", testDecodeUIntTypeMismatchWhenValueNotConvertable),
                ("testDecodeUIntTypeMismatchWhenValueNotCorrectContainerType", testDecodeUIntTypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeUInt8ValueNotFoundWhenValueIsNil", testDecodeUInt8ValueNotFoundWhenValueIsNil),
                ("testDecodeUInt8ValueNotFoundWhenContainerIsNil", testDecodeUInt8ValueNotFoundWhenContainerIsNil),
                ("testDecodeUInt8ValueNotFoundWhenNoMoreValues", testDecodeUInt8ValueNotFoundWhenNoMoreValues),
                ("testDecodeUInt8TypeMismatchWhenValueNotConvertable", testDecodeUInt8TypeMismatchWhenValueNotConvertable),
                ("testDecodeUInt8TypeMismatchWhenValueNotCorrectContainerType", testDecodeUInt8TypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeUInt16ValueNotFoundWhenValueIsNil", testDecodeUInt16ValueNotFoundWhenValueIsNil),
                ("testDecodeUInt16ValueNotFoundWhenContainerIsNil", testDecodeUInt16ValueNotFoundWhenContainerIsNil),
                ("testDecodeUInt16ValueNotFoundWhenNoMoreValues", testDecodeUInt16ValueNotFoundWhenNoMoreValues),
                ("testDecodeUInt16TypeMismatchWhenValueNotConvertable", testDecodeUInt16TypeMismatchWhenValueNotConvertable),
                ("testDecodeUInt16TypeMismatchWhenValueNotCorrectContainerType", testDecodeUInt16TypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeUInt32ValueNotFoundWhenValueIsNil", testDecodeUInt32ValueNotFoundWhenValueIsNil),
                ("testDecodeUInt32ValueNotFoundWhenContainerIsNil", testDecodeUInt32ValueNotFoundWhenContainerIsNil),
                ("testDecodeUInt32ValueNotFoundWhenNoMoreValues", testDecodeUInt32ValueNotFoundWhenNoMoreValues),
                ("testDecodeUInt32TypeMismatchWhenValueNotConvertable", testDecodeUInt32TypeMismatchWhenValueNotConvertable),
                ("testDecodeUInt32TypeMismatchWhenValueNotCorrectContainerType", testDecodeUInt32TypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeUInt64ValueNotFoundWhenValueIsNil", testDecodeUInt64ValueNotFoundWhenValueIsNil),
                ("testDecodeUInt64ValueNotFoundWhenContainerIsNil", testDecodeUInt64ValueNotFoundWhenContainerIsNil),
                ("testDecodeUInt64ValueNotFoundWhenNoMoreValues", testDecodeUInt64ValueNotFoundWhenNoMoreValues),
                ("testDecodeUInt64TypeMismatchWhenValueNotConvertable", testDecodeUInt64TypeMismatchWhenValueNotConvertable),
                ("testDecodeUInt64TypeMismatchWhenValueNotCorrectContainerType", testDecodeUInt64TypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeFloatValueNotFoundWhenValueIsNil", testDecodeFloatValueNotFoundWhenValueIsNil),
                ("testDecodeFloatValueNotFoundWhenContainerIsNil", testDecodeFloatValueNotFoundWhenContainerIsNil),
                ("testDecodeFloatValueNotFoundWhenNoMoreValues", testDecodeFloatValueNotFoundWhenNoMoreValues),
                ("testDecodeFloatTypeMismatchWhenValueNotConvertable", testDecodeFloatTypeMismatchWhenValueNotConvertable),
                ("testDecodeFloatTypeMismatchWhenValueNotCorrectContainerType", testDecodeFloatTypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeDoubleValueNotFoundWhenValueIsNil", testDecodeDoubleValueNotFoundWhenValueIsNil),
                ("testDecodeDoubleValueNotFoundWhenContainerIsNil", testDecodeDoubleValueNotFoundWhenContainerIsNil),
                ("testDecodeDoubleValueNotFoundWhenNoMoreValues", testDecodeDoubleValueNotFoundWhenNoMoreValues),
                ("testDecodeDoubleTypeMismatchWhenValueNotConvertable", testDecodeDoubleTypeMismatchWhenValueNotConvertable),
                ("testDecodeDoubleTypeMismatchWhenValueNotCorrectContainerType", testDecodeDoubleTypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeStringValueNotFoundWhenValueIsNil", testDecodeStringValueNotFoundWhenValueIsNil),
                ("testDecodeStringValueNotFoundWhenContainerIsNil", testDecodeStringValueNotFoundWhenContainerIsNil),
                ("testDecodeStringValueNotFoundWhenNoMoreValues", testDecodeStringValueNotFoundWhenNoMoreValues),
                ("testDecodeStringTypeMismatchWhenValueNotConvertable", testDecodeStringTypeMismatchWhenValueNotConvertable),
                ("testDecodeStringTypeMismatchWhenValueNotCorrectContainerType", testDecodeStringTypeMismatchWhenValueNotCorrectContainerType),
                ("testDecodeCodableTypeValueNotFoundWhenValueIsNil", testDecodeCodableTypeValueNotFoundWhenValueIsNil),
                ("testDecodeCodableTypeValueNotFoundWhenContainerIsNil", testDecodeCodableTypeValueNotFoundWhenContainerIsNil),
                ("testDecodeCodableTypeValueNotFoundWhenNoMoreValues", testDecodeCodableTypeValueNotFoundWhenNoMoreValues),
                ("testDecodeCodableTypeTypeMismatchWhenValueNotConvertable", testDecodeCodableTypeTypeMismatchWhenValueNotConvertable),
                ("testDecodeCodableTypeTypeMismatchWhenValueNotCorrectContainerType", testDecodeCodableTypeTypeMismatchWhenValueNotCorrectContainerType)
           ]
   }
}

extension UnkeyedStorageContainerTests {
   static var allTests: [(String, (UnkeyedStorageContainerTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testPush", testPush),
                ("testSubscript", testSubscript),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testDescriptionWithValues", testDescriptionWithValues),
                ("testDebugDescriptionWithValues", testDebugDescriptionWithValues)
           ]
   }
}

extension UnkeyedStorageContainerElementReferenceTests {
   static var allTests: [(String, (UnkeyedStorageContainerElementReferenceTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testValueGet", testValueGet),
                ("testValueSet", testValueSet),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testDescriptionWithValue", testDescriptionWithValue),
                ("testDebugDescriptionWithValue", testDebugDescriptionWithValue)
           ]
   }
}

extension BinaryEncodingStructuredTypeTests {
   static var allTests: [(String, (BinaryEncodingStructuredTypeTests) -> () throws -> Void)] {
      return [
                ("testEncodingDecodeOfArrayOfInt", testEncodingDecodeOfArrayOfInt),
                ("testEncodingDecodeOfDictionaryOfEnum", testEncodingDecodeOfDictionaryOfEnum),
                ("testEncodingDecodeOfDictionaryOfEnumValues", testEncodingDecodeOfDictionaryOfEnumValues),
                ("testEncodingDecodeOfDictionaryOfEnumKeys", testEncodingDecodeOfDictionaryOfEnumKeys),
                ("testEncodingDecodeOfBasicClass", testEncodingDecodeOfBasicClass),
                ("testEncodingDecodeOfBasicStruct", testEncodingDecodeOfBasicStruct),
                ("testEncodingDecodeOfComplexClass", testEncodingDecodeOfComplexClass),
                ("testEncodingDecodeOfComplexStruct", testEncodingDecodeOfComplexStruct),
                ("testEncodingDecodeOfComplexSubclassClass", testEncodingDecodeOfComplexSubclassClass)
           ]
   }
}

extension EncodedTypeTests {
   static var allTests: [(String, (EncodedTypeTests) -> () throws -> Void)] {
      return [
                ("testEncodedTypeForBool", testEncodedTypeForBool),
                ("testDescriptionForBool", testDescriptionForBool),
                ("testDebugDescriptionForBool", testDebugDescriptionForBool),
                ("testEncodedTypeForInt", testEncodedTypeForInt),
                ("testDescriptionForInt", testDescriptionForInt),
                ("testDebugDescriptionForInt", testDebugDescriptionForInt),
                ("testEncodedTypeForInt8", testEncodedTypeForInt8),
                ("testDescriptionForInt8", testDescriptionForInt8),
                ("testDebugDescriptionForInt8", testDebugDescriptionForInt8),
                ("testEncodedTypeForInt16", testEncodedTypeForInt16),
                ("testDescriptionForInt16", testDescriptionForInt16),
                ("testDebugDescriptionForInt16", testDebugDescriptionForInt16),
                ("testEncodedTypeForInt32", testEncodedTypeForInt32),
                ("testDescriptionForInt32", testDescriptionForInt32),
                ("testDebugDescriptionForInt32", testDebugDescriptionForInt32),
                ("testEncodedTypeForInt64", testEncodedTypeForInt64),
                ("testDescriptionForInt64", testDescriptionForInt64),
                ("testDebugDescriptionForInt64", testDebugDescriptionForInt64),
                ("testEncodedTypeForUInt", testEncodedTypeForUInt),
                ("testDescriptionForUInt", testDescriptionForUInt),
                ("testDebugDescriptionForUInt", testDebugDescriptionForUInt),
                ("testEncodedTypeForUInt8", testEncodedTypeForUInt8),
                ("testDescriptionForUInt8", testDescriptionForUInt8),
                ("testDebugDescriptionForUInt8", testDebugDescriptionForUInt8),
                ("testEncodedTypeForUInt16", testEncodedTypeForUInt16),
                ("testDescriptionForUInt16", testDescriptionForUInt16),
                ("testDebugDescriptionForUInt16", testDebugDescriptionForUInt16),
                ("testEncodedTypeForUInt32", testEncodedTypeForUInt32),
                ("testDescriptionForUInt32", testDescriptionForUInt32),
                ("testDebugDescriptionForUInt32", testDebugDescriptionForUInt32),
                ("testEncodedTypeForUInt64", testEncodedTypeForUInt64),
                ("testDescriptionForUInt64", testDescriptionForUInt64),
                ("testDebugDescriptionForUInt64", testDebugDescriptionForUInt64),
                ("testEncodedTypeForFloat", testEncodedTypeForFloat),
                ("testDescriptionForFloat", testDescriptionForFloat),
                ("testDebugDescriptionForFloat", testDebugDescriptionForFloat),
                ("testEncodedTypeForDouble", testEncodedTypeForDouble),
                ("testDescriptionForDouble", testDescriptionForDouble),
                ("testDebugDescriptionForDouble", testDebugDescriptionForDouble),
                ("testEncodedTypeForString", testEncodedTypeForString),
                ("testDescriptionForString", testDescriptionForString),
                ("testDebugDescriptionForString", testDebugDescriptionForString),
                ("testDescriptionForUnknownType", testDescriptionForUnknownType),
                ("testDebugDescriptionForUnknownType", testDebugDescriptionForUnknownType)
           ]
   }
}

extension EncodedTypePerformanceTests {
   static var allTests: [(String, (EncodedTypePerformanceTests) -> () throws -> Void)] {
      return [
                ("testEncodedTypeForBoolPerformance", testEncodedTypeForBoolPerformance),
                ("testEncodedTypeForIntPerformance", testEncodedTypeForIntPerformance),
                ("testEncodedTypeForInt8Performance", testEncodedTypeForInt8Performance),
                ("testEncodedTypeForInt16Performance", testEncodedTypeForInt16Performance),
                ("testEncodedTypeForInt32Performance", testEncodedTypeForInt32Performance),
                ("testEncodedTypeForInt64Performance", testEncodedTypeForInt64Performance),
                ("testEncodedTypeForUIntPerformance", testEncodedTypeForUIntPerformance),
                ("testEncodedTypeForUInt8Performance", testEncodedTypeForUInt8Performance),
                ("testEncodedTypeForUInt16Performance", testEncodedTypeForUInt16Performance),
                ("testEncodedTypeForUInt32Performance", testEncodedTypeForUInt32Performance),
                ("testEncodedTypeForUInt64Performance", testEncodedTypeForUInt64Performance),
                ("testEncodedTypeForFloatPerformance", testEncodedTypeForFloatPerformance),
                ("testEncodedTypeForDoublePerformance", testEncodedTypeForDoublePerformance),
                ("testEncodedTypeForStringPerformance", testEncodedTypeForStringPerformance)
           ]
   }
}

extension StorageContainerReferenceTests {
   static var allTests: [(String, (StorageContainerReferenceTests) -> () throws -> Void)] {
      return [
                ("testCanImplement", testCanImplement)
           ]
   }
}

extension PassthroughReferenceTests {
   static var allTests: [(String, (PassthroughReferenceTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testInitWithValue", testInitWithValue),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testDescriptionWithWrappedValue", testDescriptionWithWrappedValue),
                ("testDebugDescriptionWithWrappedValue", testDebugDescriptionWithWrappedValue)
           ]
   }
}

extension BinaryEncodingUnkeyedContainerTests {
   static var allTests: [(String, (BinaryEncodingUnkeyedContainerTests) -> () throws -> Void)] {
      return [
                ("testEncodeDecodeOfClassBoolUnkeyed", testEncodeDecodeOfClassBoolUnkeyed),
                ("testEncodeDecodeOfClassOptionalBoolUnkeyed", testEncodeDecodeOfClassOptionalBoolUnkeyed),
                ("testEncodeDecodeOfClassOptionalBoolWithNilUnkeyed", testEncodeDecodeOfClassOptionalBoolWithNilUnkeyed),
                ("testEncodeDecodeOfStructBoolUnkeyed", testEncodeDecodeOfStructBoolUnkeyed),
                ("testEncodeDecodeOfStructOptionalBoolUnkeyed", testEncodeDecodeOfStructOptionalBoolUnkeyed),
                ("testEncodeDecodeOfStructOptionalBoolWithNilUnkeyed", testEncodeDecodeOfStructOptionalBoolWithNilUnkeyed),
                ("testEncodeDecodeOfClassIntUnkeyed", testEncodeDecodeOfClassIntUnkeyed),
                ("testEncodeDecodeOfClassOptionalIntUnkeyed", testEncodeDecodeOfClassOptionalIntUnkeyed),
                ("testEncodeDecodeOfClassOptionalIntWithNilUnkeyed", testEncodeDecodeOfClassOptionalIntWithNilUnkeyed),
                ("testEncodeDecodeOfStructIntUnkeyed", testEncodeDecodeOfStructIntUnkeyed),
                ("testEncodeDecodeOfStructOptionalIntUnkeyed", testEncodeDecodeOfStructOptionalIntUnkeyed),
                ("testEncodeDecodeOfStructOptionalIntWithNilUnkeyed", testEncodeDecodeOfStructOptionalIntWithNilUnkeyed),
                ("testEncodeDecodeOfClassInt8Unkeyed", testEncodeDecodeOfClassInt8Unkeyed),
                ("testEncodeDecodeOfClassOptionalInt8Unkeyed", testEncodeDecodeOfClassOptionalInt8Unkeyed),
                ("testEncodeDecodeOfClassOptionalInt8WithNilUnkeyed", testEncodeDecodeOfClassOptionalInt8WithNilUnkeyed),
                ("testEncodeDecodeOfStructInt8Unkeyed", testEncodeDecodeOfStructInt8Unkeyed),
                ("testEncodeDecodeOfStructOptionalInt8Unkeyed", testEncodeDecodeOfStructOptionalInt8Unkeyed),
                ("testEncodeDecodeOfStructOptionalInt8WithNilUnkeyed", testEncodeDecodeOfStructOptionalInt8WithNilUnkeyed),
                ("testEncodeDecodeOfClassInt16Unkeyed", testEncodeDecodeOfClassInt16Unkeyed),
                ("testEncodeDecodeOfClassOptionalInt16Unkeyed", testEncodeDecodeOfClassOptionalInt16Unkeyed),
                ("testEncodeDecodeOfClassOptionalInt16WithNilUnkeyed", testEncodeDecodeOfClassOptionalInt16WithNilUnkeyed),
                ("testEncodeDecodeOfStructInt16Unkeyed", testEncodeDecodeOfStructInt16Unkeyed),
                ("testEncodeDecodeOfStructOptionalInt16Unkeyed", testEncodeDecodeOfStructOptionalInt16Unkeyed),
                ("testEncodeDecodeOfStructOptionalInt16WithNilUnkeyed", testEncodeDecodeOfStructOptionalInt16WithNilUnkeyed),
                ("testEncodeDecodeOfClassInt32Unkeyed", testEncodeDecodeOfClassInt32Unkeyed),
                ("testEncodeDecodeOfClassOptionalInt32Unkeyed", testEncodeDecodeOfClassOptionalInt32Unkeyed),
                ("testEncodeDecodeOfClassOptionalInt32WithNilUnkeyed", testEncodeDecodeOfClassOptionalInt32WithNilUnkeyed),
                ("testEncodeDecodeOfStructInt32Unkeyed", testEncodeDecodeOfStructInt32Unkeyed),
                ("testEncodeDecodeOfStructOptionalInt32Unkeyed", testEncodeDecodeOfStructOptionalInt32Unkeyed),
                ("testEncodeDecodeOfStructOptionalInt32WithNilUnkeyed", testEncodeDecodeOfStructOptionalInt32WithNilUnkeyed),
                ("testEncodeDecodeOfClassInt64Unkeyed", testEncodeDecodeOfClassInt64Unkeyed),
                ("testEncodeDecodeOfClassOptionalInt64Unkeyed", testEncodeDecodeOfClassOptionalInt64Unkeyed),
                ("testEncodeDecodeOfClassOptionalInt64WithNilUnkeyed", testEncodeDecodeOfClassOptionalInt64WithNilUnkeyed),
                ("testEncodeDecodeOfStructInt64Unkeyed", testEncodeDecodeOfStructInt64Unkeyed),
                ("testEncodeDecodeOfStructOptionalInt64Unkeyed", testEncodeDecodeOfStructOptionalInt64Unkeyed),
                ("testEncodeDecodeOfStructOptionalInt64WithNilUnkeyed", testEncodeDecodeOfStructOptionalInt64WithNilUnkeyed),
                ("testEncodeDecodeOfClassUIntUnkeyed", testEncodeDecodeOfClassUIntUnkeyed),
                ("testEncodeDecodeOfClassOptionalUIntUnkeyed", testEncodeDecodeOfClassOptionalUIntUnkeyed),
                ("testEncodeDecodeOfClassOptionalUIntWithNilUnkeyed", testEncodeDecodeOfClassOptionalUIntWithNilUnkeyed),
                ("testEncodeDecodeOfStructUIntUnkeyed", testEncodeDecodeOfStructUIntUnkeyed),
                ("testEncodeDecodeOfStructOptionalUIntUnkeyed", testEncodeDecodeOfStructOptionalUIntUnkeyed),
                ("testEncodeDecodeOfStructOptionalUIntWithNilUnkeyed", testEncodeDecodeOfStructOptionalUIntWithNilUnkeyed),
                ("testEncodeDecodeOfClassUInt8Unkeyed", testEncodeDecodeOfClassUInt8Unkeyed),
                ("testEncodeDecodeOfClassOptionalUInt8Unkeyed", testEncodeDecodeOfClassOptionalUInt8Unkeyed),
                ("testEncodeDecodeOfClassOptionalUInt8WithNilUnkeyed", testEncodeDecodeOfClassOptionalUInt8WithNilUnkeyed),
                ("testEncodeDecodeOfStructUInt8Unkeyed", testEncodeDecodeOfStructUInt8Unkeyed),
                ("testEncodeDecodeOfStructOptionalUInt8Unkeyed", testEncodeDecodeOfStructOptionalUInt8Unkeyed),
                ("testEncodeDecodeOfStructOptionalUInt8WithNilUnkeyed", testEncodeDecodeOfStructOptionalUInt8WithNilUnkeyed),
                ("testEncodeDecodeOfClassUInt16Unkeyed", testEncodeDecodeOfClassUInt16Unkeyed),
                ("testEncodeDecodeOfClassOptionalUInt16Unkeyed", testEncodeDecodeOfClassOptionalUInt16Unkeyed),
                ("testEncodeDecodeOfClassOptionalUInt16WithNilUnkeyed", testEncodeDecodeOfClassOptionalUInt16WithNilUnkeyed),
                ("testEncodeDecodeOfStructUInt16Unkeyed", testEncodeDecodeOfStructUInt16Unkeyed),
                ("testEncodeDecodeOfStructOptionalUInt16Unkeyed", testEncodeDecodeOfStructOptionalUInt16Unkeyed),
                ("testEncodeDecodeOfStructOptionalUInt16WithNilUnkeyed", testEncodeDecodeOfStructOptionalUInt16WithNilUnkeyed),
                ("testEncodeDecodeOfClassUInt32Unkeyed", testEncodeDecodeOfClassUInt32Unkeyed),
                ("testEncodeDecodeOfClassOptionalUInt32Unkeyed", testEncodeDecodeOfClassOptionalUInt32Unkeyed),
                ("testEncodeDecodeOfClassOptionalUInt32WithNilUnkeyed", testEncodeDecodeOfClassOptionalUInt32WithNilUnkeyed),
                ("testEncodeDecodeOfStructUInt32Unkeyed", testEncodeDecodeOfStructUInt32Unkeyed),
                ("testEncodeDecodeOfStructOptionalUInt32Unkeyed", testEncodeDecodeOfStructOptionalUInt32Unkeyed),
                ("testEncodeDecodeOfStructOptionalUInt32WithNilUnkeyed", testEncodeDecodeOfStructOptionalUInt32WithNilUnkeyed),
                ("testEncodeDecodeOfClassUInt64Unkeyed", testEncodeDecodeOfClassUInt64Unkeyed),
                ("testEncodeDecodeOfClassOptionalUInt64Unkeyed", testEncodeDecodeOfClassOptionalUInt64Unkeyed),
                ("testEncodeDecodeOfClassOptionalUInt64WithNilUnkeyed", testEncodeDecodeOfClassOptionalUInt64WithNilUnkeyed),
                ("testEncodeDecodeOfStructUInt64Unkeyed", testEncodeDecodeOfStructUInt64Unkeyed),
                ("testEncodeDecodeOfStructOptionalUInt64Unkeyed", testEncodeDecodeOfStructOptionalUInt64Unkeyed),
                ("testEncodeDecodeOfStructOptionalUInt64WithNilUnkeyed", testEncodeDecodeOfStructOptionalUInt64WithNilUnkeyed),
                ("testEncodeDecodeOfClassFloatUnkeyed", testEncodeDecodeOfClassFloatUnkeyed),
                ("testEncodeDecodeOfClassOptionalFloatUnkeyed", testEncodeDecodeOfClassOptionalFloatUnkeyed),
                ("testEncodeDecodeOfClassOptionalFloatWithNilUnkeyed", testEncodeDecodeOfClassOptionalFloatWithNilUnkeyed),
                ("testEncodeDecodeOfStructFloatUnkeyed", testEncodeDecodeOfStructFloatUnkeyed),
                ("testEncodeDecodeOfStructOptionalFloatUnkeyed", testEncodeDecodeOfStructOptionalFloatUnkeyed),
                ("testEncodeDecodeOfStructOptionalFloatWithNilUnkeyed", testEncodeDecodeOfStructOptionalFloatWithNilUnkeyed),
                ("testEncodeDecodeOfClassDoubleUnkeyed", testEncodeDecodeOfClassDoubleUnkeyed),
                ("testEncodeDecodeOfClassOptionalDoubleUnkeyed", testEncodeDecodeOfClassOptionalDoubleUnkeyed),
                ("testEncodeDecodeOfClassOptionalDoubleWithNilUnkeyed", testEncodeDecodeOfClassOptionalDoubleWithNilUnkeyed),
                ("testEncodeDecodeOfStructDoubleUnkeyed", testEncodeDecodeOfStructDoubleUnkeyed),
                ("testEncodeDecodeOfStructOptionalDoubleUnkeyed", testEncodeDecodeOfStructOptionalDoubleUnkeyed),
                ("testEncodeDecodeOfStructOptionalDoubleWithNilUnkeyed", testEncodeDecodeOfStructOptionalDoubleWithNilUnkeyed),
                ("testEncodeDecodeOfClassStringUnkeyed", testEncodeDecodeOfClassStringUnkeyed),
                ("testEncodeDecodeOfClassOptionalStringUnkeyed", testEncodeDecodeOfClassOptionalStringUnkeyed),
                ("testEncodeDecodeOfClassOptionalStringWithNilUnkeyed", testEncodeDecodeOfClassOptionalStringWithNilUnkeyed),
                ("testEncodeDecodeOfStructStringUnkeyed", testEncodeDecodeOfStructStringUnkeyed),
                ("testEncodeDecodeOfStructOptionalStringUnkeyed", testEncodeDecodeOfStructOptionalStringUnkeyed),
                ("testEncodeDecodeOfStructOptionalStringWithNilUnkeyed", testEncodeDecodeOfStructOptionalStringWithNilUnkeyed),
                ("testEncodeDecodeOfClassCodableTypeUnkeyed", testEncodeDecodeOfClassCodableTypeUnkeyed),
                ("testEncodeDecodeOfClassOptionalCodableTypeUnkeyed", testEncodeDecodeOfClassOptionalCodableTypeUnkeyed),
                ("testEncodeDecodeOfClassOptionalCodableTypeWithNilUnkeyed", testEncodeDecodeOfClassOptionalCodableTypeWithNilUnkeyed),
                ("testEncodeDecodeOfStructCodableTypeUnkeyed", testEncodeDecodeOfStructCodableTypeUnkeyed),
                ("testEncodeDecodeOfStructOptionalCodableTypeUnkeyed", testEncodeDecodeOfStructOptionalCodableTypeUnkeyed),
                ("testEncodeDecodeOfStructOptionalCodableTypeWithNilUnkeyed", testEncodeDecodeOfStructOptionalCodableTypeWithNilUnkeyed),
                ("testEncodeNilWithUnkeyedContainer", testEncodeNilWithUnkeyedContainer),
                ("testEncodeDecodeWithUnkeyedAndNestedUnkeyedContainer", testEncodeDecodeWithUnkeyedAndNestedUnkeyedContainer),
                ("testEncodeDecodeWithUnkeyedAndNestedKeyedContainers", testEncodeDecodeWithUnkeyedAndNestedKeyedContainers),
                ("testEncodeCallingMultipleUnkeyedContainers", testEncodeCallingMultipleUnkeyedContainers),
                ("testEncodeDecodeUnkeyedContainerCount", testEncodeDecodeUnkeyedContainerCount),
                ("testEncodeDecodeOfStructClassType", testEncodeDecodeOfStructClassType)
           ]
   }
}

extension BinaryEncodingKeyedContainerTests {
   static var allTests: [(String, (BinaryEncodingKeyedContainerTests) -> () throws -> Void)] {
      return [
                ("testEncodeDecodeOfClassBoolKeyed", testEncodeDecodeOfClassBoolKeyed),
                ("testEncodeDecodeOfClassOptionalBoolKeyed", testEncodeDecodeOfClassOptionalBoolKeyed),
                ("testEncodeDecodeOfClassOptionalBoolWithNilKeyed", testEncodeDecodeOfClassOptionalBoolWithNilKeyed),
                ("testEncodeDecodeOfStructBoolKeyed", testEncodeDecodeOfStructBoolKeyed),
                ("testEncodeDecodeOfStructOptionalBoolKeyed", testEncodeDecodeOfStructOptionalBoolKeyed),
                ("testEncodeDecodeOfStructOptionalBoolWithNilKeyed", testEncodeDecodeOfStructOptionalBoolWithNilKeyed),
                ("testEncodeDecodeOfClassIntKeyed", testEncodeDecodeOfClassIntKeyed),
                ("testEncodeDecodeOfClassOptionalIntKeyed", testEncodeDecodeOfClassOptionalIntKeyed),
                ("testEncodeDecodeOfClassOptionalIntWithNilKeyed", testEncodeDecodeOfClassOptionalIntWithNilKeyed),
                ("testEncodeDecodeOfStructIntKeyed", testEncodeDecodeOfStructIntKeyed),
                ("testEncodeDecodeOfStructOptionalIntKeyed", testEncodeDecodeOfStructOptionalIntKeyed),
                ("testEncodeDecodeOfStructOptionalIntWithNilKeyed", testEncodeDecodeOfStructOptionalIntWithNilKeyed),
                ("testEncodeDecodeOfClassInt8Keyed", testEncodeDecodeOfClassInt8Keyed),
                ("testEncodeDecodeOfClassOptionalInt8Keyed", testEncodeDecodeOfClassOptionalInt8Keyed),
                ("testEncodeDecodeOfClassOptionalInt8WithNilKeyed", testEncodeDecodeOfClassOptionalInt8WithNilKeyed),
                ("testEncodeDecodeOfStructInt8Keyed", testEncodeDecodeOfStructInt8Keyed),
                ("testEncodeDecodeOfStructOptionalInt8Keyed", testEncodeDecodeOfStructOptionalInt8Keyed),
                ("testEncodeDecodeOfStructOptionalInt8WithNilKeyed", testEncodeDecodeOfStructOptionalInt8WithNilKeyed),
                ("testEncodeDecodeOfClassInt16Keyed", testEncodeDecodeOfClassInt16Keyed),
                ("testEncodeDecodeOfClassOptionalInt16Keyed", testEncodeDecodeOfClassOptionalInt16Keyed),
                ("testEncodeDecodeOfClassOptionalInt16WithNilKeyed", testEncodeDecodeOfClassOptionalInt16WithNilKeyed),
                ("testEncodeDecodeOfStructInt16Keyed", testEncodeDecodeOfStructInt16Keyed),
                ("testEncodeDecodeOfStructOptionalInt16Keyed", testEncodeDecodeOfStructOptionalInt16Keyed),
                ("testEncodeDecodeOfStructOptionalInt16WithNilKeyed", testEncodeDecodeOfStructOptionalInt16WithNilKeyed),
                ("testEncodeDecodeOfClassInt32Keyed", testEncodeDecodeOfClassInt32Keyed),
                ("testEncodeDecodeOfClassOptionalInt32Keyed", testEncodeDecodeOfClassOptionalInt32Keyed),
                ("testEncodeDecodeOfClassOptionalInt32WithNilKeyed", testEncodeDecodeOfClassOptionalInt32WithNilKeyed),
                ("testEncodeDecodeOfStructInt32Keyed", testEncodeDecodeOfStructInt32Keyed),
                ("testEncodeDecodeOfStructOptionalInt32Keyed", testEncodeDecodeOfStructOptionalInt32Keyed),
                ("testEncodeDecodeOfStructOptionalInt32WithNilKeyed", testEncodeDecodeOfStructOptionalInt32WithNilKeyed),
                ("testEncodeDecodeOfClassInt64Keyed", testEncodeDecodeOfClassInt64Keyed),
                ("testEncodeDecodeOfClassOptionalInt64Keyed", testEncodeDecodeOfClassOptionalInt64Keyed),
                ("testEncodeDecodeOfClassOptionalInt64WithNilKeyed", testEncodeDecodeOfClassOptionalInt64WithNilKeyed),
                ("testEncodeDecodeOfStructInt64Keyed", testEncodeDecodeOfStructInt64Keyed),
                ("testEncodeDecodeOfStructOptionalInt64Keyed", testEncodeDecodeOfStructOptionalInt64Keyed),
                ("testEncodeDecodeOfStructOptionalInt64WithNilKeyed", testEncodeDecodeOfStructOptionalInt64WithNilKeyed),
                ("testEncodeDecodeOfClassUIntKeyed", testEncodeDecodeOfClassUIntKeyed),
                ("testEncodeDecodeOfClassOptionalUIntKeyed", testEncodeDecodeOfClassOptionalUIntKeyed),
                ("testEncodeDecodeOfClassOptionalUIntWithNilKeyed", testEncodeDecodeOfClassOptionalUIntWithNilKeyed),
                ("testEncodeDecodeOfStructUIntKeyed", testEncodeDecodeOfStructUIntKeyed),
                ("testEncodeDecodeOfStructOptionalUIntKeyed", testEncodeDecodeOfStructOptionalUIntKeyed),
                ("testEncodeDecodeOfStructOptionalUIntWithNilKeyed", testEncodeDecodeOfStructOptionalUIntWithNilKeyed),
                ("testEncodeDecodeOfClassUInt8Keyed", testEncodeDecodeOfClassUInt8Keyed),
                ("testEncodeDecodeOfClassOptionalUInt8Keyed", testEncodeDecodeOfClassOptionalUInt8Keyed),
                ("testEncodeDecodeOfClassOptionalUInt8WithNilKeyed", testEncodeDecodeOfClassOptionalUInt8WithNilKeyed),
                ("testEncodeDecodeOfStructUInt8Keyed", testEncodeDecodeOfStructUInt8Keyed),
                ("testEncodeDecodeOfStructOptionalUInt8Keyed", testEncodeDecodeOfStructOptionalUInt8Keyed),
                ("testEncodeDecodeOfStructOptionalUInt8WithNilKeyed", testEncodeDecodeOfStructOptionalUInt8WithNilKeyed),
                ("testEncodeDecodeOfClassUInt16Keyed", testEncodeDecodeOfClassUInt16Keyed),
                ("testEncodeDecodeOfClassOptionalUInt16Keyed", testEncodeDecodeOfClassOptionalUInt16Keyed),
                ("testEncodeDecodeOfClassOptionalUInt16WithNilKeyed", testEncodeDecodeOfClassOptionalUInt16WithNilKeyed),
                ("testEncodeDecodeOfStructUInt16Keyed", testEncodeDecodeOfStructUInt16Keyed),
                ("testEncodeDecodeOfStructOptionalUInt16Keyed", testEncodeDecodeOfStructOptionalUInt16Keyed),
                ("testEncodeDecodeOfStructOptionalUInt16WithNilKeyed", testEncodeDecodeOfStructOptionalUInt16WithNilKeyed),
                ("testEncodeDecodeOfClassUInt32Keyed", testEncodeDecodeOfClassUInt32Keyed),
                ("testEncodeDecodeOfClassOptionalUInt32Keyed", testEncodeDecodeOfClassOptionalUInt32Keyed),
                ("testEncodeDecodeOfClassOptionalUInt32WithNilKeyed", testEncodeDecodeOfClassOptionalUInt32WithNilKeyed),
                ("testEncodeDecodeOfStructUInt32Keyed", testEncodeDecodeOfStructUInt32Keyed),
                ("testEncodeDecodeOfStructOptionalUInt32Keyed", testEncodeDecodeOfStructOptionalUInt32Keyed),
                ("testEncodeDecodeOfStructOptionalUInt32WithNilKeyed", testEncodeDecodeOfStructOptionalUInt32WithNilKeyed),
                ("testEncodeDecodeOfClassUInt64Keyed", testEncodeDecodeOfClassUInt64Keyed),
                ("testEncodeDecodeOfClassOptionalUInt64Keyed", testEncodeDecodeOfClassOptionalUInt64Keyed),
                ("testEncodeDecodeOfClassOptionalUInt64WithNilKeyed", testEncodeDecodeOfClassOptionalUInt64WithNilKeyed),
                ("testEncodeDecodeOfStructUInt64Keyed", testEncodeDecodeOfStructUInt64Keyed),
                ("testEncodeDecodeOfStructOptionalUInt64Keyed", testEncodeDecodeOfStructOptionalUInt64Keyed),
                ("testEncodeDecodeOfStructOptionalUInt64WithNilKeyed", testEncodeDecodeOfStructOptionalUInt64WithNilKeyed),
                ("testEncodeDecodeOfClassFloatKeyed", testEncodeDecodeOfClassFloatKeyed),
                ("testEncodeDecodeOfClassOptionalFloatKeyed", testEncodeDecodeOfClassOptionalFloatKeyed),
                ("testEncodeDecodeOfClassOptionalFloatWithNilKeyed", testEncodeDecodeOfClassOptionalFloatWithNilKeyed),
                ("testEncodeDecodeOfStructFloatKeyed", testEncodeDecodeOfStructFloatKeyed),
                ("testEncodeDecodeOfStructOptionalFloatKeyed", testEncodeDecodeOfStructOptionalFloatKeyed),
                ("testEncodeDecodeOfStructOptionalFloatWithNilKeyed", testEncodeDecodeOfStructOptionalFloatWithNilKeyed),
                ("testEncodeDecodeOfClassDoubleKeyed", testEncodeDecodeOfClassDoubleKeyed),
                ("testEncodeDecodeOfClassOptionalDoubleKeyed", testEncodeDecodeOfClassOptionalDoubleKeyed),
                ("testEncodeDecodeOfClassOptionalDoubleWithNilKeyed", testEncodeDecodeOfClassOptionalDoubleWithNilKeyed),
                ("testEncodeDecodeOfStructDoubleKeyed", testEncodeDecodeOfStructDoubleKeyed),
                ("testEncodeDecodeOfStructOptionalDoubleKeyed", testEncodeDecodeOfStructOptionalDoubleKeyed),
                ("testEncodeDecodeOfStructOptionalDoubleWithNilKeyed", testEncodeDecodeOfStructOptionalDoubleWithNilKeyed),
                ("testEncodeDecodeOfClassStringKeyed", testEncodeDecodeOfClassStringKeyed),
                ("testEncodeDecodeOfClassOptionalStringKeyed", testEncodeDecodeOfClassOptionalStringKeyed),
                ("testEncodeDecodeOfClassOptionalStringWithNilKeyed", testEncodeDecodeOfClassOptionalStringWithNilKeyed),
                ("testEncodeDecodeOfStructStringKeyed", testEncodeDecodeOfStructStringKeyed),
                ("testEncodeDecodeOfStructOptionalStringKeyed", testEncodeDecodeOfStructOptionalStringKeyed),
                ("testEncodeDecodeOfStructOptionalStringWithNilKeyed", testEncodeDecodeOfStructOptionalStringWithNilKeyed),
                ("testEncodeDecodeOfClassCodableTypeKeyed", testEncodeDecodeOfClassCodableTypeKeyed),
                ("testEncodeDecodeOfClassOptionalCodableTypeKeyed", testEncodeDecodeOfClassOptionalCodableTypeKeyed),
                ("testEncodeDecodeOfClassOptionalCodableTypeWithNilKeyed", testEncodeDecodeOfClassOptionalCodableTypeWithNilKeyed),
                ("testEncodeDecodeOfStructCodableTypeKeyed", testEncodeDecodeOfStructCodableTypeKeyed),
                ("testEncodeDecodeOfStructOptionalCodableTypeKeyed", testEncodeDecodeOfStructOptionalCodableTypeKeyed),
                ("testEncodeDecodeOfStructOptionalCodableTypeWithNilKeyed", testEncodeDecodeOfStructOptionalCodableTypeWithNilKeyed),
                ("testEncodeDecodeNilWithKeyedContainer", testEncodeDecodeNilWithKeyedContainer),
                ("testEncodeDecodeWithKeyedAndNestedKeyedContainers", testEncodeDecodeWithKeyedAndNestedKeyedContainers),
                ("testEncodeWithKeyedAndNestedUnkeyedContainers", testEncodeWithKeyedAndNestedUnkeyedContainers),
                ("testEncodeCallingMultipleKeyedContainers", testEncodeCallingMultipleKeyedContainers),
                ("testEncodeDecodeWithSuperEncoderDecoderKeyedContainer", testEncodeDecodeWithSuperEncoderDecoderKeyedContainer),
                ("testEncodeDecodeWithSuperEncoderDecoderUnkeyedContainer", testEncodeDecodeWithSuperEncoderDecoderUnkeyedContainer)
           ]
   }
}

extension StorageContainerTests {
   static var allTests: [(String, (StorageContainerTests) -> () throws -> Void)] {
      return [
                ("testCanImplement", testCanImplement)
           ]
   }
}

extension NullStorageContainerTests {
   static var allTests: [(String, (NullStorageContainerTests) -> () throws -> Void)] {
      return [
                ("testNull", testNull),
                ("testNullIsTheSameObject", testNullIsTheSameObject),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription)
           ]
   }
}

extension BinaryCodingKeyTests {
   static var allTests: [(String, (BinaryCodingKeyTests) -> () throws -> Void)] {
      return [
                ("testInitWithString", testInitWithString),
                ("testFailableInitWithString", testFailableInitWithString),
                ("testInitWithInt", testInitWithInt),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testDescriptionWithInt", testDescriptionWithInt),
                ("testDebugDescriptionWithInt", testDebugDescriptionWithInt)
           ]
   }
}

extension BinaryEncoderUserObjectNegativeTests {
   static var allTests: [(String, (BinaryEncoderUserObjectNegativeTests) -> () throws -> Void)] {
      return [
                ("testEncodeWithUserObjectThrowing", testEncodeWithUserObjectThrowing)
           ]
   }
}

extension SingleValueContainerTests {
   static var allTests: [(String, (SingleValueContainerTests) -> () throws -> Void)] {
      return [
                ("testInitWithBool", testInitWithBool),
                ("testTypeWithBool", testTypeWithBool),
                ("testSizeWithBool", testSizeWithBool),
                ("testValueWithBool", testValueWithBool),
                ("testUnsafeMutableRawBufferPointerRoundTripOfBool", testUnsafeMutableRawBufferPointerRoundTripOfBool),
                ("testDescriptionWithBool", testDescriptionWithBool),
                ("testDebugDescriptionWithBool", testDebugDescriptionWithBool),
                ("testInitWithInt", testInitWithInt),
                ("testTypeWithInt", testTypeWithInt),
                ("testSizeWithInt", testSizeWithInt),
                ("testValueWithInt", testValueWithInt),
                ("testUnsafeMutableRawBufferPointerRoundTripOfInt", testUnsafeMutableRawBufferPointerRoundTripOfInt),
                ("testCanStoreIntMin", testCanStoreIntMin),
                ("testCanStoreIntMax", testCanStoreIntMax),
                ("testDescriptionWithInt", testDescriptionWithInt),
                ("testDebugDescriptionWithInt", testDebugDescriptionWithInt),
                ("testInitWithInt8", testInitWithInt8),
                ("testTypeWithInt8", testTypeWithInt8),
                ("testSizeWithInt8", testSizeWithInt8),
                ("testValueWithInt8", testValueWithInt8),
                ("testUnsafeMutableRawBufferPointerRoundTripOfInt8", testUnsafeMutableRawBufferPointerRoundTripOfInt8),
                ("testCanStoreInt8Min", testCanStoreInt8Min),
                ("testCanStoreInt8Max", testCanStoreInt8Max),
                ("testDescriptionWithInt8", testDescriptionWithInt8),
                ("testDebugDescriptionWithInt8", testDebugDescriptionWithInt8),
                ("testInitWithInt16", testInitWithInt16),
                ("testTypeWithInt16", testTypeWithInt16),
                ("testSizeWithInt16", testSizeWithInt16),
                ("testValueWithInt16", testValueWithInt16),
                ("testUnsafeMutableRawBufferPointerRoundTripOfInt16", testUnsafeMutableRawBufferPointerRoundTripOfInt16),
                ("testCanStoreInt16Min", testCanStoreInt16Min),
                ("testCanStoreInt16Max", testCanStoreInt16Max),
                ("testDescriptionWithInt16", testDescriptionWithInt16),
                ("testDebugDescriptionWithInt16", testDebugDescriptionWithInt16),
                ("testInitWithInt32", testInitWithInt32),
                ("testTypeWithInt32", testTypeWithInt32),
                ("testSizeWithInt32", testSizeWithInt32),
                ("testValueWithInt32", testValueWithInt32),
                ("testUnsafeMutableRawBufferPointerRoundTripOfInt32", testUnsafeMutableRawBufferPointerRoundTripOfInt32),
                ("testCanStoreInt32Min", testCanStoreInt32Min),
                ("testCanStoreInt32Max", testCanStoreInt32Max),
                ("testDescriptionWithInt32", testDescriptionWithInt32),
                ("testDebugDescriptionWithInt32", testDebugDescriptionWithInt32),
                ("testInitWithInt64", testInitWithInt64),
                ("testTypeWithInt64", testTypeWithInt64),
                ("testSizeWithInt64", testSizeWithInt64),
                ("testValueWithInt64", testValueWithInt64),
                ("testUnsafeMutableRawBufferPointerRoundTripOfInt64", testUnsafeMutableRawBufferPointerRoundTripOfInt64),
                ("testCanStoreInt64Min", testCanStoreInt64Min),
                ("testCanStoreInt64Max", testCanStoreInt64Max),
                ("testDescriptionWithInt64", testDescriptionWithInt64),
                ("testDebugDescriptionWithInt64", testDebugDescriptionWithInt64),
                ("testInitWithUInt", testInitWithUInt),
                ("testTypeWithUInt", testTypeWithUInt),
                ("testSizeWithUInt", testSizeWithUInt),
                ("testValueWithUInt", testValueWithUInt),
                ("testUnsafeMutableRawBufferPointerRoundTripOfUInt", testUnsafeMutableRawBufferPointerRoundTripOfUInt),
                ("testCanStoreUIntMin", testCanStoreUIntMin),
                ("testCanStoreUIntMax", testCanStoreUIntMax),
                ("testDescriptionWithUInt", testDescriptionWithUInt),
                ("testDebugDescriptionWithUInt", testDebugDescriptionWithUInt),
                ("testInitWithUInt8", testInitWithUInt8),
                ("testTypeWithUInt8", testTypeWithUInt8),
                ("testSizeWithUInt8", testSizeWithUInt8),
                ("testValueWithUInt8", testValueWithUInt8),
                ("testUnsafeMutableRawBufferPointerRoundTripOfUInt8", testUnsafeMutableRawBufferPointerRoundTripOfUInt8),
                ("testCanStoreUInt8Min", testCanStoreUInt8Min),
                ("testCanStoreUInt8Max", testCanStoreUInt8Max),
                ("testDescriptionWithUInt8", testDescriptionWithUInt8),
                ("testDebugDescriptionWithUInt8", testDebugDescriptionWithUInt8),
                ("testInitWithUInt16", testInitWithUInt16),
                ("testTypeWithUInt16", testTypeWithUInt16),
                ("testSizeWithUInt16", testSizeWithUInt16),
                ("testValueWithUInt16", testValueWithUInt16),
                ("testUnsafeMutableRawBufferPointerRoundTripOfUInt16", testUnsafeMutableRawBufferPointerRoundTripOfUInt16),
                ("testCanStoreUInt16Min", testCanStoreUInt16Min),
                ("testCanStoreUInt16Max", testCanStoreUInt16Max),
                ("testDescriptionWithUInt16", testDescriptionWithUInt16),
                ("testDebugDescriptionWithUInt16", testDebugDescriptionWithUInt16),
                ("testInitWithUInt32", testInitWithUInt32),
                ("testTypeWithUInt32", testTypeWithUInt32),
                ("testSizeWithUInt32", testSizeWithUInt32),
                ("testValueWithUInt32", testValueWithUInt32),
                ("testUnsafeMutableRawBufferPointerRoundTripOfUInt32", testUnsafeMutableRawBufferPointerRoundTripOfUInt32),
                ("testCanStoreUInt32Min", testCanStoreUInt32Min),
                ("testCanStoreUInt32Max", testCanStoreUInt32Max),
                ("testDescriptionWithUInt32", testDescriptionWithUInt32),
                ("testDebugDescriptionWithUInt32", testDebugDescriptionWithUInt32),
                ("testInitWithUInt64", testInitWithUInt64),
                ("testTypeWithUInt64", testTypeWithUInt64),
                ("testSizeWithUInt64", testSizeWithUInt64),
                ("testValueWithUInt64", testValueWithUInt64),
                ("testUnsafeMutableRawBufferPointerRoundTripOfUInt64", testUnsafeMutableRawBufferPointerRoundTripOfUInt64),
                ("testCanStoreUInt64Min", testCanStoreUInt64Min),
                ("testCanStoreUInt64Max", testCanStoreUInt64Max),
                ("testDescriptionWithUInt64", testDescriptionWithUInt64),
                ("testDebugDescriptionWithUInt64", testDebugDescriptionWithUInt64),
                ("testInitWithFloat", testInitWithFloat),
                ("testTypeWithFloat", testTypeWithFloat),
                ("testSizeWithFloat", testSizeWithFloat),
                ("testValueWithFloat", testValueWithFloat),
                ("testUnsafeMutableRawBufferPointerRoundTripOfFloat", testUnsafeMutableRawBufferPointerRoundTripOfFloat),
                ("testCanStoreFloatInfinity", testCanStoreFloatInfinity),
                ("testCanStoreFloatNan", testCanStoreFloatNan),
                ("testDescriptionWithFloat", testDescriptionWithFloat),
                ("testDebugDescriptionWithFloat", testDebugDescriptionWithFloat),
                ("testInitWithDouble", testInitWithDouble),
                ("testTypeWithDouble", testTypeWithDouble),
                ("testSizeWithDouble", testSizeWithDouble),
                ("testValueWithDouble", testValueWithDouble),
                ("testUnsafeMutableRawBufferPointerRoundTripOfDouble", testUnsafeMutableRawBufferPointerRoundTripOfDouble),
                ("testCanStoreDoubleInfinity", testCanStoreDoubleInfinity),
                ("testCanStoreDoubleNan", testCanStoreDoubleNan),
                ("testDescriptionWithDouble", testDescriptionWithDouble),
                ("testDebugDescriptionWithDouble", testDebugDescriptionWithDouble),
                ("testInitWithString", testInitWithString),
                ("testTypeWithString", testTypeWithString),
                ("testSizeWithString", testSizeWithString),
                ("testValueWithString", testValueWithString),
                ("testUnsafeMutableRawBufferPointerRoundTripOfString", testUnsafeMutableRawBufferPointerRoundTripOfString),
                ("testDescriptionWithString", testDescriptionWithString),
                ("testDebugDescriptionWithString", testDebugDescriptionWithString),
                ("testCanStoreStringUnicodeGlobes", testCanStoreStringUnicodeGlobes),
                ("testCanStoreStringUnicodeFlags", testCanStoreStringUnicodeFlags),
                ("testCanStoreStringUnicodeEPlusAccent", testCanStoreStringUnicodeEPlusAccent),
                ("testCanStoreStringUnicodeEWithAccent", testCanStoreStringUnicodeEWithAccent),
                ("testCanStoreLargeRandomString100k", testCanStoreLargeRandomString100k),
                ("testCanStoreLargeRandomString1000k", testCanStoreLargeRandomString1000k)
           ]
   }
}

extension SingleValueContainerPerformanceTests {
   static var allTests: [(String, (SingleValueContainerPerformanceTests) -> () throws -> Void)] {
      return [
                ("testInitWithBoolPerformance", testInitWithBoolPerformance),
                ("testTypeWithBoolPerformance", testTypeWithBoolPerformance),
                ("testSizeWithBoolPerformance", testSizeWithBoolPerformance),
                ("testValueWithBoolPerformance", testValueWithBoolPerformance),
                ("testInitWithIntPerformance", testInitWithIntPerformance),
                ("testTypeWithIntPerformance", testTypeWithIntPerformance),
                ("testSizeWithIntPerformance", testSizeWithIntPerformance),
                ("testValueWithIntPerformance", testValueWithIntPerformance),
                ("testInitWithInt8Performance", testInitWithInt8Performance),
                ("testTypeWithInt8Performance", testTypeWithInt8Performance),
                ("testSizeWithInt8Performance", testSizeWithInt8Performance),
                ("testValueWithInt8Performance", testValueWithInt8Performance),
                ("testInitWithInt16Performance", testInitWithInt16Performance),
                ("testTypeWithInt16Performance", testTypeWithInt16Performance),
                ("testSizeWithInt16Performance", testSizeWithInt16Performance),
                ("testValueWithInt16Performance", testValueWithInt16Performance),
                ("testInitWithInt32Performance", testInitWithInt32Performance),
                ("testTypeWithInt32Performance", testTypeWithInt32Performance),
                ("testSizeWithInt32Performance", testSizeWithInt32Performance),
                ("testValueWithInt32Performance", testValueWithInt32Performance),
                ("testInitWithInt64Performance", testInitWithInt64Performance),
                ("testTypeWithInt64Performance", testTypeWithInt64Performance),
                ("testSizeWithInt64Performance", testSizeWithInt64Performance),
                ("testValueWithInt64Performance", testValueWithInt64Performance),
                ("testInitWithUIntPerformance", testInitWithUIntPerformance),
                ("testTypeWithUIntPerformance", testTypeWithUIntPerformance),
                ("testSizeWithUIntPerformance", testSizeWithUIntPerformance),
                ("testValueWithUIntPerformance", testValueWithUIntPerformance),
                ("testInitWithUInt8Performance", testInitWithUInt8Performance),
                ("testTypeWithUInt8Performance", testTypeWithUInt8Performance),
                ("testSizeWithUInt8Performance", testSizeWithUInt8Performance),
                ("testValueWithUInt8Performance", testValueWithUInt8Performance),
                ("testInitWithUInt16Performance", testInitWithUInt16Performance),
                ("testTypeWithUInt16Performance", testTypeWithUInt16Performance),
                ("testSizeWithUInt16Performance", testSizeWithUInt16Performance),
                ("testValueWithUInt16Performance", testValueWithUInt16Performance),
                ("testInitWithUInt32Performance", testInitWithUInt32Performance),
                ("testTypeWithUInt32Performance", testTypeWithUInt32Performance),
                ("testSizeWithUInt32Performance", testSizeWithUInt32Performance),
                ("testValueWithUInt32Performance", testValueWithUInt32Performance),
                ("testInitWithUInt64Performance", testInitWithUInt64Performance),
                ("testTypeWithUInt64Performance", testTypeWithUInt64Performance),
                ("testSizeWithUInt64Performance", testSizeWithUInt64Performance),
                ("testValueWithUInt64Performance", testValueWithUInt64Performance),
                ("testInitWithFloatPerformance", testInitWithFloatPerformance),
                ("testTypeWithFloatPerformance", testTypeWithFloatPerformance),
                ("testSizeWithFloatPerformance", testSizeWithFloatPerformance),
                ("testValueWithFloatPerformance", testValueWithFloatPerformance),
                ("testInitWithDoublePerformance", testInitWithDoublePerformance),
                ("testTypeWithDoublePerformance", testTypeWithDoublePerformance),
                ("testSizeWithDoublePerformance", testSizeWithDoublePerformance),
                ("testValueWithDoublePerformance", testValueWithDoublePerformance),
                ("testInitWithStringPerformance", testInitWithStringPerformance),
                ("testTypeWithStringPerformance", testTypeWithStringPerformance),
                ("testSizeWithStringPerformance", testSizeWithStringPerformance),
                ("testValueWithStringPerformance", testValueWithStringPerformance),
                ("testInitWithLargeRandomString100kPerformance", testInitWithLargeRandomString100kPerformance),
                ("testValueWithLargeRandomString100kPerformance", testValueWithLargeRandomString100kPerformance),
                ("testInitWithLargeRandomString1000kPerformance", testInitWithLargeRandomString1000kPerformance),
                ("testValueWithLargeRandomString1000kPerformance", testValueWithLargeRandomString1000kPerformance)
           ]
   }
}

extension DecodingError_ExtensionsTests {
   static var allTests: [(String, (DecodingError_ExtensionsTests) -> () throws -> Void)] {
      return [
                ("testKeyNotFoundError", testKeyNotFoundError),
                ("testTypeMismatchErrorForActuaTypeNullStorageContainer", testTypeMismatchErrorForActuaTypeNullStorageContainer),
                ("testTypeMismatchErrorForActuaTypeKeyedStorageContainer", testTypeMismatchErrorForActuaTypeKeyedStorageContainer),
                ("testTypeMismatchErrorForActuaTypeUnkeyedStorageContainer", testTypeMismatchErrorForActuaTypeUnkeyedStorageContainer),
                ("testTypeMismatchErrorForActuaTypeSingleValueContainer", testTypeMismatchErrorForActuaTypeSingleValueContainer),
                ("testTypeMismatchErrorForActuaTypeInt", testTypeMismatchErrorForActuaTypeInt),
                ("testTypeMismatchErrorForActuaTypeEncodedInt", testTypeMismatchErrorForActuaTypeEncodedInt),
                ("testValueNotFound", testValueNotFound),
                ("testValueNotFoundIsAtEnd", testValueNotFoundIsAtEnd)
           ]
   }
}

extension BinaryEncodingSingleValueContainerTests {
   static var allTests: [(String, (BinaryEncodingSingleValueContainerTests) -> () throws -> Void)] {
      return [
                ("testEncodingDecodeOfBool", testEncodingDecodeOfBool),
                ("testEncodingDecodeOfOptionalBool", testEncodingDecodeOfOptionalBool),
                ("testEncodingDecodeOfOptionalBoolNil", testEncodingDecodeOfOptionalBoolNil),
                ("testEncodingDecodeOfInt", testEncodingDecodeOfInt),
                ("testEncodingDecodeOfOptionalInt", testEncodingDecodeOfOptionalInt),
                ("testEncodingDecodeOfOptionalIntNil", testEncodingDecodeOfOptionalIntNil),
                ("testEncodingDecodeOfIntZero", testEncodingDecodeOfIntZero),
                ("testEncodingDecodeOfIntMin", testEncodingDecodeOfIntMin),
                ("testEncodingDecodeOfIntMax", testEncodingDecodeOfIntMax),
                ("testEncodingDecodeOfOptionalIntZero", testEncodingDecodeOfOptionalIntZero),
                ("testEncodingDecodeOfOptionalIntMin", testEncodingDecodeOfOptionalIntMin),
                ("testEncodingDecodeOfOptionalIntMax", testEncodingDecodeOfOptionalIntMax),
                ("testEncodingDecodeOfInt8", testEncodingDecodeOfInt8),
                ("testEncodingDecodeOfOptionalInt8", testEncodingDecodeOfOptionalInt8),
                ("testEncodingDecodeOfOptionalInt8Nil", testEncodingDecodeOfOptionalInt8Nil),
                ("testEncodingDecodeOfInt8Zero", testEncodingDecodeOfInt8Zero),
                ("testEncodingDecodeOfInt8Min", testEncodingDecodeOfInt8Min),
                ("testEncodingDecodeOfInt8Max", testEncodingDecodeOfInt8Max),
                ("testEncodingDecodeOfOptionalInt8Zero", testEncodingDecodeOfOptionalInt8Zero),
                ("testEncodingDecodeOfOptionalInt8Min", testEncodingDecodeOfOptionalInt8Min),
                ("testEncodingDecodeOfOptionalInt8Max", testEncodingDecodeOfOptionalInt8Max),
                ("testEncodingDecodeOfInt16", testEncodingDecodeOfInt16),
                ("testEncodingDecodeOfOptionalInt16", testEncodingDecodeOfOptionalInt16),
                ("testEncodingDecodeOfOptionalInt16Nil", testEncodingDecodeOfOptionalInt16Nil),
                ("testEncodingDecodeOfInt16Zero", testEncodingDecodeOfInt16Zero),
                ("testEncodingDecodeOfInt16Min", testEncodingDecodeOfInt16Min),
                ("testEncodingDecodeOfInt16Max", testEncodingDecodeOfInt16Max),
                ("testEncodingDecodeOfOptionalInt16Zero", testEncodingDecodeOfOptionalInt16Zero),
                ("testEncodingDecodeOfOptionalInt16Min", testEncodingDecodeOfOptionalInt16Min),
                ("testEncodingDecodeOfOptionalInt16Max", testEncodingDecodeOfOptionalInt16Max),
                ("testEncodingDecodeOfInt32", testEncodingDecodeOfInt32),
                ("testEncodingDecodeOfOptionalInt32", testEncodingDecodeOfOptionalInt32),
                ("testEncodingDecodeOfOptionalInt32Nil", testEncodingDecodeOfOptionalInt32Nil),
                ("testEncodingDecodeOfInt32Zero", testEncodingDecodeOfInt32Zero),
                ("testEncodingDecodeOfInt32Min", testEncodingDecodeOfInt32Min),
                ("testEncodingDecodeOfInt32Max", testEncodingDecodeOfInt32Max),
                ("testEncodingDecodeOfOptionalInt32Zero", testEncodingDecodeOfOptionalInt32Zero),
                ("testEncodingDecodeOfOptionalInt32Min", testEncodingDecodeOfOptionalInt32Min),
                ("testEncodingDecodeOfOptionalInt32Max", testEncodingDecodeOfOptionalInt32Max),
                ("testEncodingDecodeOfInt64", testEncodingDecodeOfInt64),
                ("testEncodingDecodeOfOptionalInt64", testEncodingDecodeOfOptionalInt64),
                ("testEncodingDecodeOfOptionalInt64Nil", testEncodingDecodeOfOptionalInt64Nil),
                ("testEncodingDecodeOfInt64Zero", testEncodingDecodeOfInt64Zero),
                ("testEncodingDecodeOfInt64Min", testEncodingDecodeOfInt64Min),
                ("testEncodingDecodeOfInt64Max", testEncodingDecodeOfInt64Max),
                ("testEncodingDecodeOfOptionalInt64Zero", testEncodingDecodeOfOptionalInt64Zero),
                ("testEncodingDecodeOfOptionalInt64Min", testEncodingDecodeOfOptionalInt64Min),
                ("testEncodingDecodeOfOptionalInt64Max", testEncodingDecodeOfOptionalInt64Max),
                ("testEncodingDecodeOfUInt", testEncodingDecodeOfUInt),
                ("testEncodingDecodeOfOptionalUInt", testEncodingDecodeOfOptionalUInt),
                ("testEncodingDecodeOfOptionalUIntNil", testEncodingDecodeOfOptionalUIntNil),
                ("testEncodingDecodeOfUIntZero", testEncodingDecodeOfUIntZero),
                ("testEncodingDecodeOfUIntMin", testEncodingDecodeOfUIntMin),
                ("testEncodingDecodeOfUIntMax", testEncodingDecodeOfUIntMax),
                ("testEncodingDecodeOfOptionalUIntZero", testEncodingDecodeOfOptionalUIntZero),
                ("testEncodingDecodeOfOptionalUIntMin", testEncodingDecodeOfOptionalUIntMin),
                ("testEncodingDecodeOfOptionalUIntMax", testEncodingDecodeOfOptionalUIntMax),
                ("testEncodingDecodeOfUInt8", testEncodingDecodeOfUInt8),
                ("testEncodingDecodeOfOptionalUInt8", testEncodingDecodeOfOptionalUInt8),
                ("testEncodingDecodeOfOptionalUInt8Nil", testEncodingDecodeOfOptionalUInt8Nil),
                ("testEncodingDecodeOfUInt8Zero", testEncodingDecodeOfUInt8Zero),
                ("testEncodingDecodeOfUInt8Min", testEncodingDecodeOfUInt8Min),
                ("testEncodingDecodeOfUInt8Max", testEncodingDecodeOfUInt8Max),
                ("testEncodingDecodeOfOptionalUInt8Zero", testEncodingDecodeOfOptionalUInt8Zero),
                ("testEncodingDecodeOfOptionalUInt8Min", testEncodingDecodeOfOptionalUInt8Min),
                ("testEncodingDecodeOfOptionalUInt8Max", testEncodingDecodeOfOptionalUInt8Max),
                ("testEncodingDecodeOfUInt16", testEncodingDecodeOfUInt16),
                ("testEncodingDecodeOfOptionalUInt16", testEncodingDecodeOfOptionalUInt16),
                ("testEncodingDecodeOfOptionalUInt16Nil", testEncodingDecodeOfOptionalUInt16Nil),
                ("testEncodingDecodeOfUInt16Zero", testEncodingDecodeOfUInt16Zero),
                ("testEncodingDecodeOfUInt16Min", testEncodingDecodeOfUInt16Min),
                ("testEncodingDecodeOfUInt16Max", testEncodingDecodeOfUInt16Max),
                ("testEncodingDecodeOfOptionalUInt16Zero", testEncodingDecodeOfOptionalUInt16Zero),
                ("testEncodingDecodeOfOptionalUInt16Min", testEncodingDecodeOfOptionalUInt16Min),
                ("testEncodingDecodeOfOptionalUInt16Max", testEncodingDecodeOfOptionalUInt16Max),
                ("testEncodingDecodeOfUInt32", testEncodingDecodeOfUInt32),
                ("testEncodingDecodeOfOptionalUInt32", testEncodingDecodeOfOptionalUInt32),
                ("testEncodingDecodeOfOptionalUInt32Nil", testEncodingDecodeOfOptionalUInt32Nil),
                ("testEncodingDecodeOfUInt32Zero", testEncodingDecodeOfUInt32Zero),
                ("testEncodingDecodeOfUInt32Min", testEncodingDecodeOfUInt32Min),
                ("testEncodingDecodeOfUInt32Max", testEncodingDecodeOfUInt32Max),
                ("testEncodingDecodeOfOptionalUInt32Zero", testEncodingDecodeOfOptionalUInt32Zero),
                ("testEncodingDecodeOfOptionalUInt32Min", testEncodingDecodeOfOptionalUInt32Min),
                ("testEncodingDecodeOfOptionalUInt32Max", testEncodingDecodeOfOptionalUInt32Max),
                ("testEncodingDecodeOfUInt64", testEncodingDecodeOfUInt64),
                ("testEncodingDecodeOfOptionalUInt64", testEncodingDecodeOfOptionalUInt64),
                ("testEncodingDecodeOfOptionalUInt64Nil", testEncodingDecodeOfOptionalUInt64Nil),
                ("testEncodingDecodeOfUInt64Zero", testEncodingDecodeOfUInt64Zero),
                ("testEncodingDecodeOfUInt64Min", testEncodingDecodeOfUInt64Min),
                ("testEncodingDecodeOfUInt64Max", testEncodingDecodeOfUInt64Max),
                ("testEncodingDecodeOfOptionalUInt64Zero", testEncodingDecodeOfOptionalUInt64Zero),
                ("testEncodingDecodeOfOptionalUInt64Min", testEncodingDecodeOfOptionalUInt64Min),
                ("testEncodingDecodeOfOptionalUInt64Max", testEncodingDecodeOfOptionalUInt64Max),
                ("testEncodingDecodeOfFloat", testEncodingDecodeOfFloat),
                ("testEncodingDecodeOfOptionalFloat", testEncodingDecodeOfOptionalFloat),
                ("testEncodingDecodeOfOptionalFloatNil", testEncodingDecodeOfOptionalFloatNil),
                ("testEncodingDecodeOfDouble", testEncodingDecodeOfDouble),
                ("testEncodingDecodeOfOptionalDouble", testEncodingDecodeOfOptionalDouble),
                ("testEncodingDecodeOfOptionalDoubleNil", testEncodingDecodeOfOptionalDoubleNil),
                ("testEncodingDecodeOfString", testEncodingDecodeOfString),
                ("testEncodingDecodeOfOptionalString", testEncodingDecodeOfOptionalString),
                ("testEncodingDecodeOfOptionalStringNil", testEncodingDecodeOfOptionalStringNil),
                ("testEncodingDecodeOfCodableType", testEncodingDecodeOfCodableType),
                ("testEncodingDecodeOfOptionalCodableType", testEncodingDecodeOfOptionalCodableType),
                ("testEncodingDecodeOfOptionalCodableTypeNil", testEncodingDecodeOfOptionalCodableTypeNil)
           ]
   }
}

extension EncodedDataTests {
   static var allTests: [(String, (EncodedDataTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testBytesRoundTripOfNullStorageContainer", testBytesRoundTripOfNullStorageContainer),
                ("testBytesRoundTripOfUnkeyedStorageContainer", testBytesRoundTripOfUnkeyedStorageContainer),
                ("testBytesRoundTripOfKeyedStorageContainer", testBytesRoundTripOfKeyedStorageContainer),
                ("testBytesRoundTripOfSingleValueContainer", testBytesRoundTripOfSingleValueContainer),
                ("testUnsafeRawBufferPointerRoundTripOfNullStorageContainer", testUnsafeRawBufferPointerRoundTripOfNullStorageContainer),
                ("testUnsafeRawBufferPointerRoundTripOfUnkeyedStorageContainer", testUnsafeRawBufferPointerRoundTripOfUnkeyedStorageContainer),
                ("testUnsafeRawBufferPointerRoundTripOfKeyedStorageContainer", testUnsafeRawBufferPointerRoundTripOfKeyedStorageContainer),
                ("testUnsafeRawBufferPointerRoundTripOfSingleValueContainer", testUnsafeRawBufferPointerRoundTripOfSingleValueContainer)
           ]
   }
}

extension BinaryEncodingSingleValueContainerNegativeTests {
   static var allTests: [(String, (BinaryEncodingSingleValueContainerNegativeTests) -> () throws -> Void)] {
      return [
                ("testDecodeValueNotFoundOfBool", testDecodeValueNotFoundOfBool),
                ("testDecodeTypeMismatchOfBool", testDecodeTypeMismatchOfBool),
                ("testDecodeTypeMismatchOfBoolWhenIncorrectContainerType", testDecodeTypeMismatchOfBoolWhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfInt", testDecodeValueNotFoundOfInt),
                ("testDecodeTypeMismatchOfInt", testDecodeTypeMismatchOfInt),
                ("testDecodeTypeMismatchOfIntWhenIncorrectContainerType", testDecodeTypeMismatchOfIntWhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfInt8", testDecodeValueNotFoundOfInt8),
                ("testDecodeTypeMismatchOfInt8", testDecodeTypeMismatchOfInt8),
                ("testDecodeTypeMismatchOfInt8WhenIncorrectContainerType", testDecodeTypeMismatchOfInt8WhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfInt16", testDecodeValueNotFoundOfInt16),
                ("testDecodeTypeMismatchOfInt16", testDecodeTypeMismatchOfInt16),
                ("testDecodeTypeMismatchOfInt16WhenIncorrectContainerType", testDecodeTypeMismatchOfInt16WhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfInt32", testDecodeValueNotFoundOfInt32),
                ("testDecodeTypeMismatchOfInt32", testDecodeTypeMismatchOfInt32),
                ("testDecodeTypeMismatchOfInt32WhenIncorrectContainerType", testDecodeTypeMismatchOfInt32WhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfInt64", testDecodeValueNotFoundOfInt64),
                ("testDecodeTypeMismatchOfInt64", testDecodeTypeMismatchOfInt64),
                ("testDecodeTypeMismatchOfInt64WhenIncorrectContainerType", testDecodeTypeMismatchOfInt64WhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfUInt", testDecodeValueNotFoundOfUInt),
                ("testDecodeTypeMismatchOfUInt", testDecodeTypeMismatchOfUInt),
                ("testDecodeTypeMismatchOfUIntWhenIncorrectContainerType", testDecodeTypeMismatchOfUIntWhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfUInt8", testDecodeValueNotFoundOfUInt8),
                ("testDecodeTypeMismatchOfUInt8", testDecodeTypeMismatchOfUInt8),
                ("testDecodeTypeMismatchOfUInt8WhenIncorrectContainerType", testDecodeTypeMismatchOfUInt8WhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfUInt16", testDecodeValueNotFoundOfUInt16),
                ("testDecodeTypeMismatchOfUInt16", testDecodeTypeMismatchOfUInt16),
                ("testDecodeTypeMismatchOfUInt16WhenIncorrectContainerType", testDecodeTypeMismatchOfUInt16WhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfUInt32", testDecodeValueNotFoundOfUInt32),
                ("testDecodeTypeMismatchOfUInt32", testDecodeTypeMismatchOfUInt32),
                ("testDecodeTypeMismatchOfUInt32WhenIncorrectContainerType", testDecodeTypeMismatchOfUInt32WhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfUInt64", testDecodeValueNotFoundOfUInt64),
                ("testDecodeTypeMismatchOfUInt64", testDecodeTypeMismatchOfUInt64),
                ("testDecodeTypeMismatchOfUInt64WhenIncorrectContainerType", testDecodeTypeMismatchOfUInt64WhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfFloat", testDecodeValueNotFoundOfFloat),
                ("testDecodeTypeMismatchOfFloat", testDecodeTypeMismatchOfFloat),
                ("testDecodeTypeMismatchOfFloatWhenIncorrectContainerType", testDecodeTypeMismatchOfFloatWhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfDouble", testDecodeValueNotFoundOfDouble),
                ("testDecodeTypeMismatchOfDouble", testDecodeTypeMismatchOfDouble),
                ("testDecodeTypeMismatchOfDoubleWhenIncorrectContainerType", testDecodeTypeMismatchOfDoubleWhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfString", testDecodeValueNotFoundOfString),
                ("testDecodeTypeMismatchOfString", testDecodeTypeMismatchOfString),
                ("testDecodeTypeMismatchOfStringWhenIncorrectContainerType", testDecodeTypeMismatchOfStringWhenIncorrectContainerType),
                ("testDecodeValueNotFoundOfCodableType", testDecodeValueNotFoundOfCodableType),
                ("testDecodeTypeMismatchOfCodableType", testDecodeTypeMismatchOfCodableType),
                ("testDecodeTypeMismatchOfCodableTypeWhenIncorrectContainerType", testDecodeTypeMismatchOfCodableTypeWhenIncorrectContainerType)
           ]
   }
}

extension StorageContainerEqualTests {
   static var allTests: [(String, (StorageContainerEqualTests) -> () throws -> Void)] {
      return [
                ("testEqualWithNullStorageContainer", testEqualWithNullStorageContainer),
                ("testNotEqualWithNullStorageContainer", testNotEqualWithNullStorageContainer),
                ("testEqualWithKeyedStorageContainer", testEqualWithKeyedStorageContainer),
                ("testNotEqualWithKeyedtorageContainer", testNotEqualWithKeyedtorageContainer),
                ("testEqualWithUnkeyedStorageContainer", testEqualWithUnkeyedStorageContainer),
                ("testNotEqualWithUnkeyedtorageContainer", testNotEqualWithUnkeyedtorageContainer),
                ("testEqualWithSingleValueeContainer", testEqualWithSingleValueeContainer),
                ("testNotEqualWithSingleValueContainer", testNotEqualWithSingleValueContainer),
                ("testEqualWithUnkeyedStorageContainerAndNestedSingleValueeContainer", testEqualWithUnkeyedStorageContainerAndNestedSingleValueeContainer),
                ("testNotEqualWithUnkeyedStorageContainerAndNestedSingleValueContainer", testNotEqualWithUnkeyedStorageContainerAndNestedSingleValueContainer),
                ("testEqualWithKeyedStorageContainerAndNestedSingleValueeContainer", testEqualWithKeyedStorageContainerAndNestedSingleValueeContainer),
                ("testNotEqualWithKeyedStorageContainerAndNestedSingleValueContainer", testNotEqualWithKeyedStorageContainerAndNestedSingleValueContainer)
           ]
   }
}

extension BinaryDecoderNegativeTests {
   static var allTests: [(String, (BinaryDecoderNegativeTests) -> () throws -> Void)] {
      return [
                ("testContainerWhenTypeMismatch", testContainerWhenTypeMismatch),
                ("testUnkeyedContainerWhenTypeMismatch", testUnkeyedContainerWhenTypeMismatch),
                ("testSingleValueContainerWhenTypeMismatch", testSingleValueContainerWhenTypeMismatch),
                ("testDecodeWithUserObjectThrowing", testDecodeWithUserObjectThrowing)
           ]
   }
}

extension StorageContainerReaderWriterTests {
   static var allTests: [(String, (StorageContainerReaderWriterTests) -> () throws -> Void)] {
      return [
                ("testReadWriteRoundTripForNullStorageContainer", testReadWriteRoundTripForNullStorageContainer),
                ("testReadWriteRoundTripForSingleValueContainer", testReadWriteRoundTripForSingleValueContainer),
                ("testReadWriteRoundTripForUnkeyedContainer", testReadWriteRoundTripForUnkeyedContainer),
                ("testReadWriteRoundTripForUnkeyedContainerWithMixedSingleValueAndNull", testReadWriteRoundTripForUnkeyedContainerWithMixedSingleValueAndNull),
                ("testReadWriteRoundTripForUnkeyedContainerWithNestedUnkeyedContainers", testReadWriteRoundTripForUnkeyedContainerWithNestedUnkeyedContainers),
                ("testReadWriteRoundTripForKeyedContainer", testReadWriteRoundTripForKeyedContainer)
           ]
   }
}

#endif
