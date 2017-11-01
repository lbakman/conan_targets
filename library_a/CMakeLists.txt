cmake_minimum_required(VERSION 3.0)
project(library_a)

if(NOT DISABLE_CONAN)
    SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake")
    include(cmake/ProjectSettings.cmake)
    conan_cmake_run(CONANFILE conanfile.py
            BASIC_SETUP CMAKE_TARGETS
            BUILD missing)
endif(NOT DISABLE_CONAN)

set(SOURCES
        src/ClassA.cpp)

set(HEADERS
        include/LibraryA/ClassA.h)

add_library(library_a STATIC ${SOURCES} ${HEADERS})
target_include_directories(library_a
        PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
        PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
        )

