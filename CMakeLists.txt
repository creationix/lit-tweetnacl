include(GenerateExportHeader)
cmake_minimum_required (VERSION 2.6)
project (luatweetnacl)
include_directories(luatweetnacl $ENV{HOME}/Code/luvi/deps/luv/deps/luajit/src)

set(files
  luatweetnacl/luatweetnacl.c
  luatweetnacl/randombytes.c
  luatweetnacl/tweetnacl.c
)

add_library(luatweetnacl SHARED ${files})
set_target_properties(luatweetnacl PROPERTIES PREFIX "")

target_link_libraries(luatweetnacl)


if (APPLE)
  TARGET_LINK_LIBRARIES(luatweetnacl "-undefined dynamic_lookup")
  set_target_properties(luatweetnacl PROPERTIES SUFFIX ".so")
endif (APPLE)
