#
# For Swift Package Manager, all output files placed in the package directories must be saved.  These include the output from gyb and LinuxMain.swift.
#
set_directory_properties(PROPERTIES CLEAN_NO_CUSTOM 1)

file(GLOB_RECURSE TEST_FILES   RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.swift)
file(GLOB_RECURSE TEST_GYB     RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.gyb)

#
# Remove LinuxMain.swift from the list as this will be handled separately if Linux.
#
list(REMOVE_ITEM TEST_FILES LinuxMain.swift)

#
# Test Target
#
add_custom_target(sticky-tests
        COMMAND swift test
        DEPENDS sticky-package
        SOURCES ${TEST_FILES} ${TEST_GYB}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        )

add_gyb_dependencies("${TEST_GYB}" sticky-tests)

if(UNIX AND NOT APPLE)

    add_custom_command(
            DEPENDS ${TEST_FILES} build-tools
            OUTPUT LinuxMain.swift
            COMMAND ${LINUXMAINTOOL}
            ARGS --package-path "${CMAKE_SOURCE_DIR}"
            VERBATIM
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )

    add_custom_target(linux-main
            DEPENDS LinuxMain.swift
            )
    add_dependencies(sticky-tests linux-main)

endif()
