#
# For Swift Package Manager, all output files placed in the package directories must be saved.  These include the output from gyb and LinuxMain.swift.
#
set_directory_properties(PROPERTIES CLEAN_NO_CUSTOM 1)

file(GLOB_RECURSE TEST_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.swift *.gyb)
file(GLOB LINUX_MAIN RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} LinuxMain.swift)

#
# Remove LinuxMain.swift from the list as this will be handled separately if Linux.
#
list(REMOVE_ITEM TEST_FILES "${LINUX_MAIN}")
get_filename_component(LINUX_MAIN ${LINUX_MAIN} ABSOLUTE BASE_DIR ${CMAKE_SOURCE_DIR})

#
# Test Target
#
add_custom_target(tests ALL
        COMMAND swift test
        DEPENDS build generate-tests ${TEST_FILES}
        SOURCES ${TEST_FILES} ${CMAKE_SOURCE_DIR}/Package.swift
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        )

# GYB Targets
set(GYB_COMMON_FLAGS --line-directive "''")

add_gyb_target(generate-BinaryEncodingKeyedContainerNegativeTests
        SOURCE StickyEncodingTests/BinaryEncodingKeyedContainerNegativeTests.swift.gyb
        OUTPUT StickyEncodingTests/BinaryEncodingKeyedContainerNegativeTests.swift
        FLAGS ${GYB_COMMON_FLAGS}
        DEPENDS build-tools
        )

add_gyb_target(generate-BinaryEncodingKeyedContainerTests
        SOURCE StickyEncodingTests/BinaryEncodingKeyedContainerTests.swift.gyb
        OUTPUT StickyEncodingTests/BinaryEncodingKeyedContainerTests.swift
        FLAGS ${GYB_COMMON_FLAGS}
        DEPENDS build-tools
        )

add_gyb_target(generate-BinaryEncodingSingleValueContainerNegativeTests
        SOURCE StickyEncodingTests/BinaryEncodingSingleValueContainerNegativeTests.swift.gyb
        OUTPUT StickyEncodingTests/BinaryEncodingSingleValueContainerNegativeTests.swift
        FLAGS ${GYB_COMMON_FLAGS}
        DEPENDS build-tools
        )

add_gyb_target(generate-BinaryEncodingSingleValueContainerTests
        SOURCE StickyEncodingTests/BinaryEncodingSingleValueContainerTests.swift.gyb
        OUTPUT StickyEncodingTests/BinaryEncodingSingleValueContainerTests.swift
        FLAGS ${GYB_COMMON_FLAGS}
        DEPENDS build-tools
        )

add_gyb_target(generate-BinaryEncodingUnkeyedContainerNegativeTests
        SOURCE StickyEncodingTests/BinaryEncodingUnkeyedContainerNegativeTests.swift.gyb
        OUTPUT StickyEncodingTests/BinaryEncodingUnkeyedContainerNegativeTests.swift
        FLAGS ${GYB_COMMON_FLAGS}
        DEPENDS build-tools
        )

add_gyb_target(generate-BinaryEncodingUnkeyedContainerTests
        SOURCE StickyEncodingTests/BinaryEncodingUnkeyedContainerTests.swift.gyb
        OUTPUT StickyEncodingTests/BinaryEncodingUnkeyedContainerTests.swift
        FLAGS ${GYB_COMMON_FLAGS}
        DEPENDS build-tools
        )

add_gyb_target(generate-EncodedTypeTests
        SOURCE StickyEncodingTests/EncodedTypeTests.swift.gyb
        OUTPUT StickyEncodingTests/EncodedTypeTests.swift
        FLAGS ${GYB_COMMON_FLAGS}
        DEPENDS build-tools
        )

add_gyb_target(generate-SingleValueContainerTests
        SOURCE StickyEncodingTests/SingleValueContainerTests.swift.gyb
        OUTPUT StickyEncodingTests/SingleValueContainerTests.swift
        FLAGS ${GYB_COMMON_FLAGS}
        DEPENDS build-tools
        )

add_custom_target(generate-tests
        DEPENDS generate-BinaryEncodingKeyedContainerNegativeTests generate-BinaryEncodingKeyedContainerTests generate-BinaryEncodingSingleValueContainerNegativeTests generate-BinaryEncodingSingleValueContainerTests generate-BinaryEncodingUnkeyedContainerNegativeTests generate-BinaryEncodingUnkeyedContainerTests generate-EncodedTypeTests generate-SingleValueContainerTests
        )

#
# Build the LinuxMain file.
#
# Note: We do this for all platforms so that we are assured that it is maintained whenever a change is made to the tests.
#
add_custom_command(
        DEPENDS tests generate-tests
        OUTPUT "${LINUX_MAIN}"
        COMMAND swift test --generate-linuxmain
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
)

add_custom_target(linux-main
        DEPENDS "${LINUX_MAIN}"
        )
