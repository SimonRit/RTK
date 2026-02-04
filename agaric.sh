#!/bin/bash -x
export CUDAARCHS=52
export PATH=/home/srit/Downloads/cuda124/bin:$PATH
export LD_LIBRARY_PATH=/home/srit/Downloads/cuda116/targets/x86_64-linux/lib:$LD_LIBRARY_PATH
export PATH=/home/srit/Downloads/cmake-3.29.0-linux-x86_64/bin:$PATH
export LD_LIBRARY_PATH=/home/srit/Downloads/cmake-3.29.0-linux-x86_64/bin:$LD_LIBRARY_PATH

ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_build_itk.cmake

ctest -R "(rtk|RTK)" -S /home/srit/src/rtk/rtk-dashboard/agaric_build_rtk_in_itk.cmake -V
ctest -R "(rtk|RTK)" -S /home/srit/src/rtk/rtk-dashboard/agaric_tbb.cmake -V

ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_cudacommon_suse_gcc.cmake -V
ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_suse_gcc.cmake -V
ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_suse_gcc_space.cmake -V

ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_cudacommon_suse_gcc_shared.cmake -V
ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_suse_gcc_shared.cmake -V

ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_cudacommon_suse_gcc_debug.cmake -V
ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_suse_gcc_debug.cmake -V

ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_cudacommon_suse_gcc_valgrind.cmake -V
ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_suse_gcc_cuda_valgrind.cmake -V

ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_suse_gcc_nocuda_valgrind.cmake -V

ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_cudacommon_suse_gcc_cuda_cov.cmake -V
ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_suse_gcc_cuda_cov.cmake -V

ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_style.cmake -V
ctest -S /home/srit/src/rtk/rtk-dashboard/agaric_doxygen.cmake -V
rsync -e 'ssh -i /home/srit/.ssh/nophrase' -a --delete \
    /export/home/rtk/dashboard_tests/RTK-Doxygen/Doxygen/html \
    ssh.creatis.insa-lyon.fr:/export/home/rtk/dashboard_tests/RTK-Doxygen/Doxygen

