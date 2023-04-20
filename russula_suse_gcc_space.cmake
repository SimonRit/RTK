# client maintainer: simon.rit@creatis.insa-lyon.fr
set(CTEST_SITE "russula.clb")
set(CTEST_BUILD_NAME "Linux 64bit-gcc space")
set(CTEST_BUILD_CONFIGURATION Release)
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(dashboard_binary_name "RTK lin64_gcc")
set(dashboard_source_name "RTK sources")
set(ENV{ITK_DIR} "/home/srit/src/itk/lin64")
set(CTEST_BUILD_FLAGS -j16)
set(CONFIGURE_OPTIONS -DCMAKE_CXX_STANDARD=17)
include("${CTEST_SCRIPT_DIRECTORY}/rtk_common.cmake")

