SRCS := mod_sub.f90 main.f90

.PHONY: all test clean

all:
	gfortran -fopenmp -fautomatic -o gfortran_build_runme.exe $(SRCS)
	ifort -qopenmp -auto -o ifort_build_runme.exe $(SRCS)

test:
	@echo 'testing gfortran build'
	./gfortran_build_runme.exe
	@echo -e \\n'===================================='\\n
	@echo 'testing ifort build'
	./ifort_build_runme.exe

clean:
	rm -f *.mod *.exe