! Tests the behavior of OpenMP orphaned directives
program main
    use omp_lib, only: omp_get_thread_num
    use mod_sub, only: sub
    implicit none
    !$omp parallel default(shared)
        print*, 'main: I am thread:', omp_get_thread_num()
        call sub(5)
    !$omp end parallel
end program main
