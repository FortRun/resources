module mod_sub
implicit none

contains

subroutine sub(m)
    use omp_lib, only: omp_get_thread_num
    integer :: i
    integer, intent(in) :: m
    
    !$omp do
    do i=1,m
        print*, 'sub_do: I am thread:', omp_get_thread_num()
    end do
    !$omp end do
    
    !$omp single
        print*, 'sub_single: I am thread:', omp_get_thread_num()
    !$omp end single
    
    !$omp critical
        print*, 'sub_critical: I am thread:', omp_get_thread_num()
    !$omp end critical    
end subroutine sub
end module mod_sub
