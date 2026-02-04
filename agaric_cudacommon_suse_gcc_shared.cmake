set(CTEST_SITE "agaric.clb")
set(ENV{ITK_DIR} "/export/home/rtk/dashboard_tests/ITK-main-Shared-Release-FFTWON")
set(CTEST_BUILD_FLAGS -j16)
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_GIT_COMMAND "git")
set(CTEST_BUILD_NAME "CudaCommon-Linux-64bit-gcc-shared")
set(CTEST_SOURCE_DIRECTORY "/export/home/rtk/dashboard_tests/CudaCommon-main")
set(CTEST_BINARY_DIRECTORY "/export/home/rtk/dashboard_tests/CudaCommon_lin64_gcc_shared")
set(CTEST_BUILD_CONFIGURATION Release)
set(CTEST_CONFIGURATION_TYPE Release)
ctest_empty_binary_directory(${CTEST_BINARY_DIRECTORY})
ctest_start(Nightly)
ctest_update()
set(cfg_options
    -DBUILD_TESTING:BOOL=ON
    -DCMAKE_CXX_STANDARD=17
    -DBUILD_SHARED_LIBS:BOOL=ON)
ctest_configure(OPTIONS "${cfg_options}")
ctest_build()
ctest_test()

# Use RTK parameters for submission
set(CTEST_PROJECT_NAME "RTK")
set(CTEST_NIGHTLY_START_TIME "1:00:00 UTC")

set(CTEST_DROP_METHOD "http")
set(CTEST_DROP_SITE "my.cdash.org")
set(CTEST_DROP_LOCATION "/submit.php?project=RTK")
set(CTEST_DROP_SITE_CDASH TRUE)
ctest_submit()

