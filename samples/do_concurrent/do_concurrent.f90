! `do concurrent` is way faster than simple `do` loop atleast for `ifort -qopenmp` but not for `ifort -parallel`
! Without the -qopenmp / -parallel flag, however, the locality information is ignored by ifort
! NOTE: PARALLELIZE THE OUTERMOST LOOP ONLY, THE INNER LOOP(S) MUST BE VECTORIZED
! Test if `do` or `do concurrent` is faster by uncommenting below the desired one.
! Compare different compilers with the present code to see which one uses multiple threads.
! ifort -O3 -qopenmp <code>; ./a.out
! ifort -O3 -parallel <code>; ./a.out
! ifort -O3 <code>; ./a.out
! gfortran -O3 <code>; ./a.out
! gfortran -O3 -fopenmp; ./a.out


real, dimension(10000) :: a=1.25, b=0.5
real :: x, t1, t2, cpu_secs, wclock_secs 
integer :: count=0, wclock_t1, wclock_t2, wclock_rate, wclock_max

call cpu_time(t1); call system_clock(wclock_t1, wclock_rate, wclock_max) ! Timestamp at the start

! Comment out either the do or do_concurrent below
! do i=1,size(a)
! do concurrent (i=1:size(a)) default(none) local (x) shared (a, b) ! This is a Fortran 2018 feature
do concurrent (i=1:size(a)) ! Does not contain any locality info: Fortran 2008 feature
  serial_inner_loop : do count=1,1000000
    if (a(i)>0.0) then
      x = sqrt (a(i))
      a(i) = a(i) - x**2
    end if
    b(i) = b(i) - a(i)
  end do serial_inner_loop
end do

call cpu_time(t2); call system_clock(wclock_t2, wclock_rate, wclock_max) ! Timestamp at the end

! Performance Stats:
cpu_secs = t2-t1
wclock_secs = (wclock_t2-wclock_t1)/real(wclock_rate)
print*, "Time spent (seconds) -"
print*, "CPU:", cpu_secs
print*, "Wallclock:", wclock_secs
print*, "# Threads:", nint(cpu_secs/wclock_secs)
end

! Results:
! Only `ifort -qopenmp` with `do concurrent` uses all threads available (4 in my case).
! `do concurrent` without locality info seems little faster
