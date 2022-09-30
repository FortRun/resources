program namlist
  integer :: indx=1
  real :: a=0.0, b=1.2
  integer, dimension(4) :: array=2
  character(len=4) :: word
  namelist /params/ indx, a, b, array, word
  open(10, file='input.nml')
    read(10, nml=params)
  close(10)
  write(*,nml=params) 
end program namlist
