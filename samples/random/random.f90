! Experimenting with random_number and random_seed
program randm

    implicit none
    integer, dimension(:), allocatable :: seeds
    real, dimension(:), allocatable :: rands
    integer :: seeds_size, clock_tick 
    
    call random_seed(size=seeds_size)
    allocate(seeds(seeds_size))
    allocate(rands(size(seeds)))
    call random_seed(get=seeds)
    write(*,*) 'current seeds = ', seeds
    call harvest_randoms()
   
    write(*,*) 're-initialising the prng with the previous seeds...'
    call random_seed(put=seeds)
    call harvest_randoms()
    
    ! Initialising with random seeds derived using system clock count 
    write(*,*) 'Initialising with random seeds derived using system clock count'
    call system_clock(count=clock_tick)
    call random_number(rands)
    rands = rands + rands - 1.0  ! random numbers in [-1, 1] 
    seeds = nint(rands*clock_tick)
    write(*,*) 'current seeds = ', seeds
    call harvest_randoms()
    
    contains
    
    subroutine harvest_randoms()
        real, dimension(5) :: r1
        real :: r2
        call random_number(r1)
        call random_number(r2)
        write(*,*) 'five random numbers : ', r1
        write(*,*) 'random number : ', r2
    end subroutine harvest_randoms
    
end program randm