! Tests the behavior of OpenMP orphaned directives
program main
    use omp_lib, only: omp_get_thread_num, omp_get_max_threads
    use mod_sub
    implicit none
    print*, 'Total threads:', omp_get_max_threads()
    !$omp parallel default(shared)
        print*, 'main: I am thread:', omp_get_thread_num()
        call parallel(6)
        call single()
        call criticl()
    !$omp end parallel
    print*, '######################'
    !$omp parallel default(shared)
        call mixed(4)
    !$omp end parallel
end program main
