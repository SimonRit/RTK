# client maintainer: simon.rit@creatis.insa-lyon.fr
set(CTEST_SITE "agaric.clb")
set(CTEST_BUILD_NAME "Linux-64bit-gcc-shared")
set(CTEST_BUILD_CONFIGURATION Release)
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(dashboard_binary_name "RTK_lin64_gcc_shared")
set(ENV{ITK_DIR} "/export/home/rtk/dashboard_tests/ITK-main-Shared-Release-FFTWON")
set(CTEST_BUILD_FLAGS -j16)
set(CONFIGURE_OPTIONS -DCMAKE_CXX_STANDARD=17)
include("${CTEST_SCRIPT_DIRECTORY}/rtk_common.cmake")

