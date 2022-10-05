! do_concurrent is way faster than simple do loop atleast for ifort
! Without the -qopenmp flag, however, the locality information is ignored by ifort
! However do_concurrent compiled with -qopenmp flag in ifort is as slow as simple do
! To check, swap/toggle the do and do_concurrent below

real, dimension(10000) :: a=1.25, b=0.5
real :: x, t1, t2
integer :: count=0
call cpu_time(t1)
serial_loop : do count=1,1000000
  ! Comment out either the do or do_concurrent below
  ! do i=1,size(a)
  do concurrent (i=1:size(a)) default(none) local (x) shared (a, b) ! This is a Fortran 2018 feature
  ! do concurrent (i=1:size(a)) ! Does not contain any locality info: Fortran 2008 feature
    if (a(i)>0.0) then
      x = sqrt (a(i))
      a(i) = a(i) - x**2
    end if
    b(i) = b(i) - a(i)
  end do
end do serial_loop
call cpu_time(t2)
print*, "Spent:", t2-t1, "Secs"
end

! Results:
! ifort with do_concurrent + locality info and without -qopenmp: 4.700233     Secs
! ifort with do_concurrent + locality info and with -qopenmp: 12.44812     Secs
! ifort with do_concurrent - locality info and without -qopenmp : 4.676138     Secs
! ifort with do_concurrent - locality info and with -qopenmp : 8.218477     Secs
! ifort with do : 12.34693     Secs
! gfortran with do : 29.8000603     Secs
! gfortran with do_concurrent (doesn't support locality yet) : 21.9149818     Secs

! Lesson:
! ifort is far better than gfortran
! ifort implementation of the Fortran 2018 feature of do_concurrent with locality specs is not mature yet
! However, the locality specs is recommended as it tells compiler everything it needs to know to parallelize efficiently

