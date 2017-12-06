#
# For Swift Package Manager, all output files placed in the package directories must be saved.  These include the output from gyb.
#
set_directory_properties(PROPERTIES CLEAN_NO_CUSTOM 1)

#
# Build the list of sources dynamically.
#
file(GLOB_RECURSE SOURCE_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.swift Package.swift)
file(GLOB_RECURSE SOURCE_GYB   RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.gyb)

#
# Main Build Target
#
add_custom_target(sticky-package
        COMMAND swift build
        BYPRODUCTS .build
        SOURCES ${SOURCE_FILES} ${TEST_SOURCE}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        )

#
# We use gyb for many files, these commands define how to build those.
#
add_gyb_dependencies("${SOURCE_GYB}" sticky-package)
