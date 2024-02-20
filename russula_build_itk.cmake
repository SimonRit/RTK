set(CTEST_SITE "morille.clb")
set(CTEST_BUILD_FLAGS -j16)
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_GIT_COMMAND "git")
set(CTEST_GIT_UPDATE_CUSTOM "${CTEST_GIT_COMMAND}" pull)
foreach(ITK_VERSION master release)
  set(CTEST_SOURCE_DIRECTORY "/home/srit/src/rtk/dashboard_tests/ITK-${ITK_VERSION}")
  foreach(FFTW ON)
    foreach(DEBUG_RELEASE Release Debug RelWithDebInfo)
      foreach(STATIC_SHARED Static Shared)
        set(BUILD_SHARED_LIBS OFF)
        if(${STATIC_SHARED} STREQUAL Shared)
          set(BUILD_SHARED_LIBS ON)
        endif()

        set(CTEST_BUILD_NAME "ITK-${ITK_VERSION}-${STATIC_SHARED}-${DEBUG_RELEASE}-FFTW${FFTW}")
        set(CTEST_BINARY_DIRECTORY "/home/srit/src/rtk/dashboard_tests/ITK-${ITK_VERSION}-${STATIC_SHARED}-${DEBUG_RELEASE}-FFTW${FFTW}")
        set(CTEST_BUILD_CONFIGURATION ${DEBUG_RELEASE})
        set(CTEST_CONFIGURATION_TYPE ${DEBUG_RELEASE})

        ctest_start(Continuous)
        ctest_update()

        set(cfg_options
           -DITK_FUTURE_LEGACY_REMOVE=ON
           -DITK_LEGACY_REMOVE=ON
           -DBUILD_EXAMPLES=OFF
           -DBUILD_TESTING=OFF
           -DITK_USE_FFTWD=${FFTW}
           -DITK_USE_FFTWF=${FFTW}
           -DITK_USE_SYSTEM_FFTW=${FFTW}
           -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
          )
        ctest_configure(OPTIONS "${cfg_options}")
        ctest_build()

        # Use RTK parameters for submission
        set(CTEST_PROJECT_NAME "RTK")
        set(CTEST_NIGHTLY_START_TIME "1:00:00 UTC")

        set(CTEST_DROP_METHOD "http")
        set(CTEST_DROP_SITE "my.cdash.org")
        set(CTEST_DROP_LOCATION "/submit.php?project=RTK")
        set(CTEST_DROP_SITE_CDASH TRUE)
        ctest_submit()
      endforeach()
    endforeach()
  endforeach()
endforeach()
