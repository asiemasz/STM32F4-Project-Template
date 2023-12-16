cmake_minimum_required(VERSION 3.16)

project(project-template LANGUAGES C CXX)

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 17)

add_compile_options(
  -Wall
  -Wextra
  -Wconversion
  -Wsign-conversion
  -g3
  -Og
)

add_subdirectory(hw)
add_subdirectory(src)
add_subdirectory(test)