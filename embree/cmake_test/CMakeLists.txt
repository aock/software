cmake_minimum_required(VERSION 3.0)
project(EmbreeInstallVerify)

set_property(GLOBAL PROPERTY FIND_LIBRARY_USE_LIB64_PATHS ON)

find_package(embree 3.0 REQUIRED)

include_directories(${EMBREE_INCLUDE_DIRS})

add_executable(example example.cpp)

target_link_libraries(example ${EMBREE_LIBRARY})
message(STATUS "embree library: ${EMBREE_LIBRARY}")
