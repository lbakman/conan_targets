cmake_minimum_required(VERSION 3.0)
project(library_b)

if(NOT DISABLE_CONAN)
    SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake")
    include(cmake/ProjectSettings.cmake)
    conan_cmake_run(CONANFILE conanfile.py
            BASIC_SETUP CMAKE_TARGETS
            BUILD missing)
else(NOT DISABLE_CONAN)
    add_library(PKG::library_a INTERFACE IMPORTED)
    set_property(TARGET PKG::library_a PROPERTY INTERFACE_LINK_LIBRARIES ${library_a_BINARY_DIR}/liblibrary_a.a)
    set_property(TARGET PKG::library_a PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${library_a_SOURCE_DIR}/include)
endif(NOT DISABLE_CONAN)

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
if(NOT DISABLE_CONAN)
    conan_target_link_libraries(library_b)
else(NOT DISABLE_CONAN)
    target_link_libraries(library_b PKG::library_a)
endif(NOT DISABLE_CONAN)

