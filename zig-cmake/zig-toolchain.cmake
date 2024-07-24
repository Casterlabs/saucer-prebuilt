set(CMAKE_C_COMPILER "zig" cc $ENV{TOOLCHAIN_TARGET})
set(CMAKE_CXX_COMPILER "zig" c++ $ENV{TOOLCHAIN_TARGET})

# if(WIN32)
#     set(SCRIPT_SUFFIX ".cmd")
# else()
#     set(SCRIPT_SUFFIX ".sh")
# endif()

# This is working (thanks to Simon for finding this trick)
# set(CMAKE_AR "${CMAKE_CURRENT_LIST_DIR}/zig-ar${SCRIPT_SUFFIX}")
# set(CMAKE_RANLIB "${CMAKE_CURRENT_LIST_DIR}/zig-ranlib${SCRIPT_SUFFIX}")
