## ----------------------------------------------------------------------------
##
##   File: CMakelists.txt
##   Copyright (c) <2013> <University of Paderborn>
##   Permission is hereby granted, free of charge, to any person
##   obtaining a copy of this software and associated documentation
##   files (the "Software"), to deal in the Software without restriction,
##   including without limitation the rights to use, copy, modify and
##   merge the Software, subject to the following conditions:
##
##   1.) The Software is used for non-commercial research and
##       education purposes.
##
##   2.) The above copyright notice and this permission notice shall be
##       included in all copies or substantial portions of the Software.
##
##   3.) Publication, Distribution, Sublicensing, and/or Selling of
##       copies or parts of the Software requires special agreements
##       with the University of Paderborn and is in general not permitted.
##
##   4.) Modifications or contributions to the software must be
##       published under this license. The University of Paderborn
##       is granted the non-exclusive right to publish modifications
##       or contributions in future versions of the Software free of charge.
##
##   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
##   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
##   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
##   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
##   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
##   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
##   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
##   OTHER DEALINGS IN THE SOFTWARE.
##
##   Persons using the Software are encouraged to notify the
##   Department of Communications Engineering at the University of Paderborn
##   about bugs. Please reference the Software in your publications
##   if it was used for them.
##
##
##   Author: Oliver Walter
##
## ----------------------------------------------------------------------------
cmake_minimum_required(VERSION 2.8)
project(LatticeWordSegmentation)
cmake_policy(SET CMP0015 NEW)

if(DEFINED ENV{BOOST_ROOT})
  set(Boost_NO_SYSTEM_PATHS ON)
endif()
set(Boost_REALPATH ON)
find_package(Boost COMPONENTS system filesystem REQUIRED)
include_directories(${Boost_INCLUDE_DIR})
link_directories(${Boost_LIBRARY_DIRS})

if(DEFINED ENV{OPENFST_DIR})
  set(OPENFST_DIR $ENV{OPENFST_DIR})
endif()
if(OPENFST_DIR)
  include_directories(SYSTEM ${OPENFST_DIR}/include)
  link_directories(${OPENFST_DIR}/lib)
endif()

include_directories(includes)
include_directories(SYSTEM NHPYLM/ext_deps/)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wextra")
add_subdirectory(FileReader)
add_subdirectory(EditDistanceCalculator)
add_subdirectory(NHPYLM)
add_subdirectory(ParameterParser)
add_subdirectory(Evaluate)

add_executable(LatticeWordSegmentation
  WordLengthProbCalculator.cpp
  LatticeWordSegmentationTimer.cpp
  LexFst.cpp
  NHPYLMFst.cpp
  SampleLib.cpp
  ParseLib.cpp
  DebugLib.cpp
  LatticeWordSegmentation.cpp
  main.cpp
)

target_link_libraries(LatticeWordSegmentation
  fst
  dl
  pthread
  FileReader
  EditDistanceCalculator
  NHPYLM
  ParameterParser
  Evaluate
)
