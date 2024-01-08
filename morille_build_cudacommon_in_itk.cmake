set(CTEST_SITE "morille.clb")
set(CTEST_GIT_COMMAND "C:\\Program Files\\Git\\bin\\git.exe")
set(CTEST_CMAKE_GENERATOR "Ninja")
foreach(ITK_VERSION "master")
  foreach(FFTW ON)
    foreach(DEBUG_RELEASE RelWithDebInfo)
      set(ENV{PATH} "C:/src/fftw/build/${DEBUG_RELEASE};$ENV{PATH}")
      foreach(STATIC_SHARED Static Shared)
        set(BUILD_SHARED_LIBS OFF)
        if(${STATIC_SHARED} STREQUAL Shared)
          set(BUILD_SHARED_LIBS ON)
        endif()
        set(CTEST_BUILD_NAME "CudaCommon-InITK-Windows7-64bit-Ninja-ITK${ITK_VERSION}-${STATIC_SHARED}-${DEBUG_RELEASE}-FFTW${FFTW}")
        set(CTEST_SOURCE_DIRECTORY "C:\\src\\itk\\ITK-${ITK_VERSION}")
        file(REMOVE_RECURSE "${CTEST_SOURCE_DIRECTORY}\\Modules\\Remote\\CudaCommon")
        set(CTEST_BINARY_DIRECTORY "C:\\CudaCommon-Ninja-${STATIC_SHARED}-${FFTW}")
        set(CTEST_BUILD_CONFIGURATION ${DEBUG_RELEASE})
        set(CTEST_CONFIGURATION_TYPE ${DEBUG_RELEASE})

        ctest_empty_binary_directory(${CTEST_BINARY_DIRECTORY})
        ctest_start(Nightly)

        ctest_update()

        set(cfg_options
            -DITK_FUTURE_LEGACY_REMOVE:BOOL=ON
            -DITK_LEGACY_REMOVE:BOOL=ON
            -DITK_BUILD_DEFAULT_MODULES:BOOL=OFF
            -DModule_CudaCommon:BOOL=ON
            -DModule_CudaCommon_GIT_TAG:STRING=master
            -DBUILD_EXAMPLES:BOOL=OFF
            -DBUILD_TESTING:BOOL=ON
            -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
            -DCMAKE_CUDA_ARCHITECTURES:STRING=52
          )
        if("${FFTW}" STREQUAL ON)
          set(cfg_options ${cfg_options}
              -DITK_USE_FFTWD:BOOL=${FFTW}
              -DITK_USE_FFTWF:BOOL=${FFTW}
              -DITK_USE_SYSTEM_FFTW:BOOL=${FFTW}
              -DFFTWD_BASE_LIB:PATH=C:/src/fftw/build/${DEBUG_RELEASE}/fftw3.lib
              -DFFTWD_LIBRARIES:PATH=C:/src/fftw/build/${DEBUG_RELEASE}/fftw3.lib
              -DFFTWD_THREADS_LIB:PATH=C:/src/fftw/build/${DEBUG_RELEASE}/fftw3.lib
              -DFFTWF_BASE_LIB:PATH=C:/src/fftw/build/${DEBUG_RELEASE}/fftw3f.lib
              -DFFTWF_LIBRARIES:PATH=C:/src/fftw/build/${DEBUG_RELEASE}/fftw3f.lib
              -DFFTWF_THREADS_LIB:PATH=C:/src/fftw/build/${DEBUG_RELEASE}/fftw3f.lib
              -DFFTW_INCLUDE_PATH:PATH=C:/src/fftw/fftw-3.3.9/api
          )
        endif()
        ctest_configure(OPTIONS "${cfg_options}")
        ctest_read_custom_files(${CTEST_BINARY_DIRECTORY})
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
      endforeach()
    endforeach()
  endforeach()
endforeach()
