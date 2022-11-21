# Comparison between using cshift and array component multiplication for 2D cross product computation

implicit none
double precision , dimension(2) :: a,b,p 
double precision :: d
real :: t1,t2
integer, parameter :: n=1000000000, m=6
integer :: i,j

a= (/1.243556599867d0,5.8797654d0/)
b= (/10.987657686d0,18.8764565799d0/)
 
 call cpu_time(t1)
 do j=1,m
 do i=1,n
!d=i-1
d= a(1)*b(2) - a(2)*b(1)
end do 
end do
call cpu_time(t2)

print*, d, t2-t1

call cpu_time(t1)
  do j=1,m
 do i=1,n
 !d=i-1
 p =  a*cshift(b,1)
 d = p(1) - p(2)
end do 
end do
call cpu_time(t2)

print*, d, t2-t1

end
