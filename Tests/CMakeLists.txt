#
# For Swift Package Manager, all output files placed in the package directories must be saved.  These include the output from gyb and LinuxMain.swift.
#
set_directory_properties(PROPERTIES CLEAN_NO_CUSTOM 1)

file(GLOB_RECURSE TEST_FILES  *.swift)
file(GLOB_RECURSE TEST_GYB    *.gyb)
file(GLOB LINUX_MAIN LinuxMain.swift)

#
# Remove LinuxMain.swift from the list as this will be handled separately if Linux.
#
list(REMOVE_ITEM TEST_FILES "${LINUX_MAIN}")

#
# Test Target
#
add_custom_target(sticky-tests
        COMMAND swift test
        DEPENDS sticky-package
        SOURCES ${TEST_FILES} ${TEST_GYB}
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        )

add_gyb_dependencies("${TEST_GYB}" sticky-tests)

if(UNIX AND NOT APPLE)

    add_custom_command(
            DEPENDS ${TEST_FILES} build-tools
            OUTPUT "${LINUX_MAIN}"
            COMMAND "${LINUXMAINTOOL}"
            ARGS --package-path "${CMAKE_SOURCE_DIR}"
            VERBATIM
    )

    add_custom_target(linux-main
            DEPENDS "${LINUX_MAIN}"
            )
    add_dependencies(sticky-tests linux-main)

endif()
