module mod_sub
    use omp_lib, only: omp_get_thread_num
    implicit none

contains

subroutine parallel(m)
    integer :: i
    integer, intent(in) :: m
    
    !$omp do
    do i=1,m
        print*, 'sub_do: I am thread:', omp_get_thread_num()
    end do
    !$omp end do
end subroutine parallel

subroutine single
    !$omp single
        print*, 'sub_single: I am thread:', omp_get_thread_num()
    !$omp end single
end subroutine single

subroutine criticl
    !$omp critical
        print*, 'sub_critical: I am thread:', omp_get_thread_num()
    !$omp end critical    
end subroutine criticl

subroutine mixed(n)
    integer, intent(in) :: n
    call parallel(n)
    call single()
    call criticl()
end subroutine mixed

end module mod_sub
