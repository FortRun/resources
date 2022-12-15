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
  - [Orphaned directives](https://wwwuser.gwdg.de/~parallel/intel_compiler_doc/f_ug2/par_prg.htm#orph) a great gift. See [samples](/samples/omp_orphaned_directive/)
  - `reduction` clause supports array variables only for Fortran
  - Use compiler option `-auto` for ifort and `-fautomatic` for gfortran while using openmp
  - Look up `OMP_STACKSIZE`
- Coarrays - Language native parallelization - using OpenMPI underneath (both opencoarrays and intel-fortran-compiler)
- OpenMPI - assembly language of parallelization.

### Numerical recipes

http://numerical.recipes/

### Compilers

- `gfortran` + [opencoarrays](http://www.opencoarrays.org/)
- `ifort` and `ifx`. Now available without registration for [free](https://www.intel.com/content/www/us/en/developer/articles/news/free-intel-software-developer-tools.html). Here's a [guide to install on Ubuntu (Linux/WSL2)](https://gist.github.com/SomajitDey/aeb6eb4c8083185e06800e1ece4be1bd).
- [Online](https://www.onlinegdb.com/)
- for standard compiler options see `FF` in this [Makefile](https://gist.github.com/SomajitDey/4462675881cc1340b76d45279764cc2f)

### Linting

- [fortran-linter](https://github.com/cphyc/fortran-linter) | [fork](https://github.com/FortRun/fortran-linter)
- [fprettify](https://github.com/pseewald/fprettify) | [fork](https://github.com/FortRun/fprettify)
- [flint](https://gitlab.com/cerfacs/flint) | [docs](https://www.atnf.csiro.au/computing/software/miriad/doc/flint.html) | [HOME](https://cerfacs.fr/coop/flint) | [a blog-article on why linting is important](https://cerfacs.fr/coop/scanninglargefortranhpccodes)
- [Commercial static analysis tools](https://fortranwiki.org/fortran/show/Commercial+static+analysis+tools)

### Bash completion

A good fortran package needs `<TAB>` completion on the command-line. Learn how to write proper bash-completion scripts and where to install them for automatic loading by bash.
- [Creating a bash completion script](https://iridakos.com/programming/2018/03/01/bash-programmable-completion-tutorial)
- [Git's completion script](https://github.com/git/git/blob/master/contrib/completion/git-completion.bash)
- [Bash manual - programmable completion example](https://www.gnu.org/software/bash/manual/html_node/A-Programmable-Completion-Example.html#A-Programmable-Completion-Example)
- [The Bash completeion project](https://github.com/scop/bash-completion/)

### Build tools

- **[A model Makefile that can be used everywhere with minimal modification](https://gist.github.com/SomajitDey/4462675881cc1340b76d45279764cc2f)**
- [Learn Make, Meson and CMake](https://fortran-lang.org/learn/building_programs/build_tools)
- Makefiles
  - [Manual](https://www.gnu.org/software/make/manual/make.html)
  - [Paul's Rules - Best Practices](https://make.mad-scientist.net/papers/rules-of-makefiles/)
  - [Paul's Methods](https://make.mad-scientist.net/papers/)
  - [Tips](https://fortran-lang.org/learn/building_programs/build_tools#using-make-as-build-tool)
  - https://github.com/theicfire/makefiletutorial or https://makefiletutorial.com/
  - [Module dependency and Make](https://lagrange.mechse.illinois.edu/f90_mod_deps/)
  - `fortdepend`: A Fortran Dependency Generator for easy inclusion in Makefiles [Docs](https://fortdepend.readthedocs.io/en/latest/) | [GitHub](https://github.com/ZedThree/fort_depend.py) | [fork](https://github.com/FortRun/fortdepend)
  - See my own [`Makefile`](/samples/omp/Makefile) along with [`config`](/samples/omp/config) script for dependency generation using `fortdepend`.
  - **Makefile Basics**
    - [Automatic variables $@, $<, $?, $^](https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html)
    - [wildcard](https://www.gnu.org/software/make/manual/make.html#Wildcards)
    - [% pattern matching](https://www.gnu.org/software/make/manual/make.html#Static-Pattern)
    - [multiple targets in one rule](https://www.gnu.org/software/make/manual/make.html#Multiple-Targets)
    - [multiple rules for one target](https://www.gnu.org/software/make/manual/make.html#Multiple-Rules)
    - $(wildcard *.something) - [wildcard pitfalls](https://www.gnu.org/software/make/manual/make.html#index-wildcard-pitfalls)
    - [Pattern rules](https://www.gnu.org/software/make/manual/make.html#Pattern-Rules)
    - [.PHONY](https://www.gnu.org/software/make/manual/make.html#Phony-Targets)
    - [Order-only prerequisites](https://www.gnu.org/software/make/manual/make.html#Prerequisite-Types)
    - Rule - Target : Prerequisite ; Recipes
    - Start with @ for no automatic `echo` of executing command
    - Each recipe line runs in own shell instance.
    - SHELL variable contains default shell
    - [Variable assignement](https://www.gnu.org/software/make/manual/make.html#Setting) - [VARIABLE := string](https://www.gnu.org/software/make/manual/make.html#Simple-Assignment) & [VARIABLE = string](https://www.gnu.org/software/make/manual/make.html#Recursive-Assignment)
    - [Substitution reference](https://www.gnu.org/software/make/manual/make.html#Substitution-Refs)
    - [Functions](https://www.gnu.org/software/make/manual/make.html#Functions) for [filenames](https://www.gnu.org/software/make/manual/make.html#File-Name-Functions)
    - [VPATH](https://www.gnu.org/software/make/manual/make.html#Directory-Search)
- [List of different tools](https://fortranwiki.org/fortran/show/Build+tools)

### Continuous Integration (CI)

Auto-build remotely on every push to upstream with public build status Markdown badge

- [GitHub Workflow/Actions - My Way](https://gist.github.com/SomajitDey/d14eb5dd7bcd79f3f14d1a7429b515af) - free for public repos
- [Travis-CI](https://docs.travis-ci.com/user/status-images/)
- Circle-CI (?)
- Self-hosted (Heroku, AWS, Digital Ocean, exposed with IPNS-Link) triggered by GitHub webhooks

### Debugging and Segfaults

- `ulimit -s unlimited`
- `export OMP_STACKSIZE=500m`
- [NASA doc](https://www.nas.nasa.gov/hecc/support/kb/common-causes-of-segmentation-faults-(segfaults)_524.html)
- [ifort doc](https://www.intel.com/content/www/us/en/developer/articles/troubleshooting/determining-root-cause-of-sigsegv-or-sigbus-errors.html)

### Profiling



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
