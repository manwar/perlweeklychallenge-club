cmake_minimum_required(VERSION 2.8)

project(ch-1)
SET(CMAKE_CXX_COMPILER "/usr/bin/clang++")
SET(CMAKE_CXX_STANDARD 20)
add_executable(${PROJECT_NAME} ch-1.cc)
add_executable(ch-2 ch-2.cc)
