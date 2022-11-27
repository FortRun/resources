module mod_omp
    use omp_lib
    implicit none

     contains
     
    subroutine parallel()
        integer :: j
    
        !$omp do
        workshare: do j=100,99+omp_get_num_threads()
            write(*,*) 'I am thread:  ',omp_get_thread_num(), ' executing workshare@subroutine step: ',j
        end do workshare
        !$omp end do
    end subroutine parallel
end module mod_omp