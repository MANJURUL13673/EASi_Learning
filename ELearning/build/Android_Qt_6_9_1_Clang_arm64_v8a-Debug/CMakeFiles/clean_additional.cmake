# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appELearning_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appELearning_autogen.dir\\ParseCache.txt"
  "appELearning_autogen"
  )
endif()
