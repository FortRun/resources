! Pointers can be used to alias components of arrays of derived types
! But will those components be stored in contiguous memory?
! The answer depends on the compiler

use iso_fortran_env, only: compiler_options, compiler_version
implicit none
type particle
  real :: x=0.0, y=0.0 ! 2d positions
  real :: vx=1.0, vy=0.0 ! 2d velocities
  real :: mass=1.0
  integer :: species_id=1
end type particle
type(particle), allocatable, dimension(:), target :: bead
real, pointer, dimension(:) :: vx, vy, rx, ry
integer :: N
print*, "Enter particle number"
read*, N
allocate(bead(N))
!bead = particle() ! Initialize each element of bead array with defaults
vx => bead%vx
print*,"Velocities along X:"
print*, vx
print*, "Is vx contiguous for compiler: ", compiler_version(), " with options: ", compiler_options()," ?"
print*, is_contiguous(vx)
end
