program main
    use omp_lib
    use mod_omp
    implicit none
    integer :: i

    !$omp parallel default(private)
        timeseries: do i=1,3
            !$omp single
            write(*,*) 'I am thread# :  ',omp_get_thread_num(), ' executing step#: ',i
            !$omp end single
            call parallel()
        end do timeseries
    !$omp end parallel
end program main
