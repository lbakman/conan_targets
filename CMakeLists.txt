cmake_minimum_required(VERSION 3.0)
project(conan_exports_project)

option(DEPEND_ON_A "Define option to make executable depend directly on A" OFF)
option(DISABLE_CONAN "Define option to use conan to manage dependencies" ON)

#set(CMAKE_LINK_DEPENDS_DEBUG_MODE ON)
if(DISABLE_CONAN)
add_subdirectory(library_a)
add_subdirectory(library_b)
endif(DISABLE_CONAN)
add_subdirectory(executable)