module mod_omp
    implicit none

     contains
     
    subroutine parallel()
        integer :: j
    
        !$omp do
        workshare: do j=11,14
            write(*,*) j
        end do workshare
        !$omp end do
    end subroutine parallel
end module mod_omp