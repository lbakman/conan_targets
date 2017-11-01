cmake_minimum_required(VERSION 3.0)
project(library_b)

include(cmake/ProjectSettings.cmake)
conan_cmake_run(CONANFILE conanfile.py
        BASIC_SETUP CMAKE_TARGETS
        BUILD missing)

set(SOURCES
        src/ClassB.cpp)

set(HEADERS
        include/LibraryB/ClassB.h)

add_library(library_b STATIC ${SOURCES} ${HEADERS})
target_include_directories(library_b
        PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
        PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
        )
conan_target_link_libraries(library_b)

