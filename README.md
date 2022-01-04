# Resources

### Language

- **Books** [Download at [1lib.in](https://1lib.in/)]
  - **Modern Fortran Explained: Incorporating Fortran 2018**. Michael Metcalf, John Reid, and Malcolm Cohen. Oxford University Press
  - **[Modern Fortran: Building Efficient Parallel Applications](http://www.manning.com/books/modern-fortran)**. Milan Curcic. Manning Publications Co..
- **Online**
  - [Modern Fortran on Unix](https://cyber.dabamos.de/programming/modernfortran/) - awesome
  - [John Mahaffy lectures at psu.edu](http://www.personal.psu.edu/jhm/f90/lectures/quickref.html)
  - [fortran-lang.org](https://fortran-lang.org/)
  - [fortran90.org](https://www.fortran90.org/)
  - [fortranwiki](https://fortranwiki.org/fortran/show/HomePage)

### Parallel

- OpenMP
  - **Using OpenMP Portable Shared Memory Parallel Programming**. Barbara Chapman et al., MIT Press, 2008
  - [Parallel Programming in Fortran 95 using OpenMP](http://www.openmp.org/wp-content/uploads/F95_OpenMPv1_v2.pdf), a guide by M. Hermanns
  - [Quick Reference Card](https://www.openmp.org/wp-content/uploads/OpenMPRef-5.0-111802-web.pdf)
- Coarrays - Language native parallelization - using OpenMPI underneath (both opencoarrays and intel-fortran-compiler)
- OpenMPI - assembly language of parallelization.

### Numerical recipes

http://numerical.recipes/

### Compilers

- `gfortran` + [opencoarrays](http://www.opencoarrays.org/)
- `ifort` and `ifx`. Now available without registration for [free](https://www.intel.com/content/www/us/en/developer/articles/news/free-intel-software-developer-tools.html). Here's a [guide to install on Ubuntu (Linux/WSL2)](https://gist.github.com/SomajitDey/aeb6eb4c8083185e06800e1ece4be1bd).
- [Online](https://www.onlinegdb.com/)

### Build tools

- [Learn Make, Meson and CMake](https://fortran-lang.org/learn/building_programs/build_tools)
- Makefiles
  - [Tips](https://fortran-lang.org/learn/building_programs/build_tools#using-make-as-build-tool)
  - https://github.com/theicfire/makefiletutorial or https://makefiletutorial.com/
  - Basics
    - [Automatic variables $@, $<, $?, $^](https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html)
    - wildcard % pattern matching - multiple targets in one rule
    - $(wildcard *.something) - wildcard pitfalls
    - Rule - Target : Prerequisite ; Recipes
    - Start with @ for no automatic `echo` of executing command
    - Each recipe line runs in own shell instance.
    - SHELL variable contains default shell
    - Variable assignement - VARIABLE : string
- [List of different tools](https://fortranwiki.org/fortran/show/Build+tools)

### Continuous Integration (CI)

Auto-build remotely on every push to upstream with public build status Markdown badge

- [Travis-CI](https://docs.travis-ci.com/user/status-images/)
- Circle-CI (?)
- Self-hosted (Heroku, AWS, Digital Ocean, exposed with IPNS-Link) triggered by GitHub webhooks

### Containerization

- Docker
  - **Docker Deep Dive - zero to Docker in a single book**, Nigel Poulton
  - [Docker docs Guides](https://docs.docker.com/get-started/overview/)

### Platform

- Linux
- WSL2 (and/or WSLg)

### Libraries

- http://numerical.recipes/
- https://github.com/fabiankindermann/ce-fortran/wiki/toolbox-documentation
- [f_](https://github.com/SomajitDey/f_)
- [stdlib](https://github.com/fortran-lang/stdlib)
- [SciFortran](https://github.com/QcmPlab/SciFortran)
- https://fortran-lang.org/packages/
- https://fortranwiki.org/fortran/show/Libraries
- https://github.com/rabbiabram/awesome-fortran
- https://github.com/szaghi
- https://github.com/urbanjost, https://github.com/urbanjost/index
- Bindings - curl, nginx, zeromq (networking): https://github.com/interkosmos;
- ZeroMQ (pubsub, tcp server etc.):  https://github.com/richsnyder/fzmq
- Redis client : https://github.com/CrayLabs/SmartRedis

### Documentation

- [ford](https://github.com/Fortran-FOSS-Programmers/ford)
- doxygen supports fortran
- [sphinx-fortran](https://sphinx-fortran.readthedocs.io/en/latest/index.html)
- GitHub Wiki
- LaTeX: 
  - **LATEX - User's guide and manual - updated for LATEX2e**, Leslie Lamport, Addison Wesley (1994)
  - [wikibook](https://en.wikibooks.org/wiki/LaTeX)
  - [overleaf.com/learn](https://www.overleaf.com/learn)

### Preprocessor

- [fypp](https://github.com/aradi/fypp)

### Visualization

- [GNUPlot](http://www.gnuplot.info/)
- [Ovito](https://www.ovito.org/)
- [GTK-fortran](https://github.com/vmagnin/gtk-fortran/wiki)
- [dialog](http://manpages.ubuntu.com/manpages/bionic/man1/dialog.1.html)

### Best practices

- https://fortran-lang.org/learn/best_practices
- https://github.com/Fortran-FOSS-Programmers/Best_Practices
- https://alm.engr.colostate.edu/cb/wiki/16983
- `do while` is deprecated in favor of `do...if() exit...end do`

### Community

- https://fortran-lang.discourse.group/

### Miscelleneous

- https://github.com/fabiankindermann/ce-fortran/wiki/Useful-links
