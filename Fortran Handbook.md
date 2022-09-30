# Fortran Handbook

Interesting and useful things to remember. Most are taken from "**Modern Fortran Explained, 2nd Edition. Michael Metcalf, John Reid, and Malcolm Cohen. Oxford University Press (2018)**", keywords are in bold sometimes. Other **resources** - 

- http://www.manning.com/books/modern-fortran : Modern Fortran by Milan Curcic
- [fortran90.org](https://www.fortran90.org/)
- [fortranwiki](https://fortranwiki.org/fortran/show/HomePage)
- [John Mahaffy lectures at psu.edu](http://www.personal.psu.edu/jhm/f90/lectures/quickref.html).

**Compiler** : `ifort` is faster than `gfortran`, also supports 2018 standard probably. And it seems intel compilers are now free: https://www.intel.com/content/www/us/en/developer/articles/news/free-intel-software-developer-tools.html

<br>

### Programming approaches

Imperative - a number of statements that the program executes top to bottom. This is the imperative style of programming—you’re telling the computer what to do, one statement after another.

Procedural - subroutines and functions

Array-oriented

Object-oriented - derived types with type bound procedures - **objects** and **subobjects**

Functional - pure functions

<br>

### When to use : and when *

- Examples of **type-parameters** are **kind** and **len**. Deferred type parameters are similar to allocatable things (i.e. **must either be allocatable *[scalars]* or pointer**), specified with **colons**(:)

  ```fortran
  real(dp), dimension(:), allocatable :: array1, array2
  real(dp), dimension(:), pointer :: array1, array2
  character(len=:), allocatable :: char ! Example of allocatable scalar to be allocated as allocate (character(reclen) :: chdata)
  character(len=:), pointer :: char ! To be allocated on pointer association
  ```

  > Deferred type-parameters
  >
  > For intrinsic types, only character length may be deferred. Derived types that are
  > parameterized may have type-parameters which can be deferred, see Section 13.2.2.
  >
  > -- Modern Fortran Explained, 2nd Edition. Michael Metcalf, John Reid, and Malcolm Cohen. Oxford University Press (2018)

- Assumed shape arrays as procedure (subroutine/function) dummy argument are specified with **:** as

  ```fortran
  real :: dummy(:)
  real, dimension(:) :: dummy1, dummy2
  integer, intent(in) :: lbound !lower-bound
  real, dimension(lbound:) :: dummy1,dummy2
  ```

- Assumed character length as procedure dummy argument however uses asterisk(\*)

  ```fortran
  character(len=*), dimension(:), intent(in) :: dummy
  ```

- For parameter specifications characters and arrays may have implied length and shape respectively, The specification uses **\*** as upper bound.

  ```fortran
  integer, parameter :: dp=kind(0.d0)
  real(dp), parameter :: array(*)=[ 1, 2, 3, 4]
  character(len=*), parameter :: string='I''m tremendously lazy'
  ```

- Assumed `len` type parameters of parameterized derived type use asterisk **\***. Deferred `len` type parameters use `:` - Chapter 13 of Metcalf, Reid, Cohen

- Assumed size arrays use `array_name(*)`, only in the context of C-functions.

  > It’s there for easier interfacing with C functions, but otherwise you shouldn’t ever use it in pure
  > Fortran programs. To quote the late Walter Brainerd in his book Guide to Fortran 2008
  > Programming: “Do not ask why—just do it.”
  >
  > --- Milan Curcic, Modern Fortran, Chapter 11: Interoperability with C

<br>

### *contiguous* and *do concurrent* - all that glitters is not gold

> The contiguous attribute is an attribute for pointer and assumed-shape dummy arrays. For an array pointer, it restricts its target to being contiguous. For an assumed-shape array, it specifies that if the corresponding actual argument is not contiguous, copy-in copy-out is used make the dummy argument contiguous.
>
> Knowing that an array is contiguous in this sense simplifies array traversal and array element address calculations, potentially improving performance. <u>Whether this improvement is significant depends on the fraction of time spent performing traversal and address calculation operations; in some programs this time is substantial, but in many cases it is insignificant in the first place</u>.
>
> -- Modern Fortran Explained, 2nd Edition. Michael Metcalf, John Reid, and Malcolm Cohen. Oxford University Press (2018)

Do not use **contiguous** for dummy array arguments if the arrays are used only once. Then copy-in, copy-out overhead is not insignificant compared to array traversal time. 

```fortran
do concurrent (integer :: i=lbound:ubound:stride, j=lbound:ubound:stride, scalar_mask_expression)
end do
```

> Note that any ordinary do loop that satisfies the limitations and which obviously has the
> required properties can be parallelized, so use of do concurrent is not necessary for parallel
> execution. In fact, a compiler that parallelizes do concurrent is likely to treat it as a request
> that it should parallelize that loop; if the loop iteration count is very small, this could result in
> worse performance than an ordinary do loop due to the overhead of initiating parallel threads
> of execution. Thus, even when the programmer-provided guarantees are trivially derived
> from the loop body itself, do concurrent is still useful for
>
> - indicating to the compiler that this is likely to have a high enough iteration count to
>   make parallelization worthwhile;
> - using the compiler to enforce the prohibitions (e.g. no calls to impure procedures);
> - documenting the parallelizability for code reading and maintenance; and
> - as a crutch to compilers whose analysis capabilities are limited.
>
> -- Modern Fortran Explained, 2nd Edition. Michael Metcalf, John Reid, and Malcolm Cohen. Oxford University Press (2018)

<br>

### *where (mask)..elsewhere(mask)..elsewhere..end where* and mask storage

> Logical arrays are needed for masking in 'where' statements and constructs (Section 7.6),
> and they play a similar role in many of the array intrinsic functions (Chapter 9). Such
> arrays are often large, and there may be a worthwhile storage gain from using non-default
> logical types, if available. For example, some processors may use bytes to store elements
> of logical(kind=1) arrays, and bits to store elements of logical(kind=0) arrays.
> Unfortunately, there is no portable facility to specify such arrays, since there is no intrinsic
> function comparable to selected_int_kind and selected_real_kind.
>
> Logical arrays are formed implicitly in certain expressions, usually as compiler-generated
> temporary variables. In
> where (a > 0.0) a = 2.0 * a
> or
> if (any(a > 0.0)) then
> (any is described in Section 9.13.1) the expression a > 0.0 is a logical array. In such a
> case, an optimizing compiler can be expected to choose a suitable kind type parameter for the
> temporary array.
>
> -- Modern Fortran Explained, 2nd Edition. Michael Metcalf, John Reid, and Malcolm Cohen. Oxford University Press (2018)

<br>

### *Pure* and *Elemental* procedures

> An interface block for an external procedure is required if the procedure itself is nonintrinsic
> and elemental. The interface must specify it as elemental. This is because the
> compiler may use a different calling mechanism in order to accommodate the array case
> efficiently. It contrasts with the case of pure procedures, where more freedom is permitted
> (see previous section).
>
> If a generic procedure reference (Section 5.18) is consistent with both an elemental and
> a non-elemental procedure, the non-elemental procedure is invoked. <u>In general, one must expect the elemental version to execute more slowly for a specific rank than the corresponding non-elemental version</u>.
>
> -- Modern Fortran Explained, 2nd Edition. Michael Metcalf, John Reid, and Malcolm Cohen. Oxford University Press (2018)

Pure (i.e. side-effect less) procedures are an aid to parallel evaluation. Elemental has the advantage of single procedure definition for both scalar and array arguments.

<br>

### Recursive functions

Use the `recursive function f(arg) result(res)` form: This is because within recursive function body, `f` can appear at the right hand side of an assignment statement, so `f` can't be at the left hand side too, thus requiring `res`. **Always make sure the recursion stops at some point - that it is not infinite. So there must be some conditional checks**.

<br>

### Explicit and Implicit interface

- Module procedures and internal procedures have explicit interface in their host
- External procedure specified with `external` has implicit interface.
- External procedure specified with `interface...end interface` has explicit interface.
- Module and internal procedures can't have nested internal procedures - i.e. can't contain `contains`.
- `.mod` files are not portable - they even depend on the compiler version! So, to have a dynamic library, put the library routines in external subprograms, and compile them into object code. Put the explicit interfaces in module source (text) files. Modules are kept small this way.
- **Interfaces help** 
  - **interoperate with external procedures written in C**
  - **dummy procedures as procedure arguments**
  - **defined operators and defined assignments**
  - **overloading, generic procedures** - procedures with arguments of different kinds

<br>

### Derived Types

- Each scalar Derived Type is a **Structure**, comparable to **struct** in C and C++. Is an Object with SubObjects. Add type bound procedures (methods in C++ speak) and you have object oriented programming (OOP).
- Derived Types can contain (as components) other derived types defined before. Recursive derived types can contain allocatable components of the type being defined. Allocatable components can also be of types to be defined later in the program unit.
- Having **pointer** or **allocatable** components helps build linked lists.

<br>

### Memory-leakage, heap, stack, pointers, targets, allocate, deallocate, nullify(), associated(), allocated()

- Variables whose size are know at compile time are given allocated to stack. Same with procedure calls. Too much recursion would cause stack overflow. Too many variables, too large arrays would cause stack overflow. For too large arrays, and arrays whose size cannot be known at compile time, use dynamic allocatability - to be allocated heap.

- `allocate()` allocates contiguous memory.

- A **pointer** refers to a memory location. If pointed to a **target**, the pointer ***descriptor*** records the target's mem location, bounds (if target is array) and stride (if target is array). A pointer can also be made to refer to a *new* memory location in the heap with `allocate()`. If reassigned, the pointer will forget about that location and that location would be inaccessible - causing **memory leakage**. There is no automatic garbage collection in Fortran. `deallocate()` before pointer dissociation. Also free RAM with deallocate() when you know an allocatable array won't be needed anymore.

- allocate() and deallocate() are slow. Use them only when needed.

- allocate() and deallocate() may fail. Handle those exceptions. Use their full form for `errmsg= and status=`.

- allocate() allocates and associates, but does not initialize. Without initialization a variable is undefined. Without association a pointer is undefined. At least use `pointer=>null() ` to define it as a null-pointer.

- Use allocatable arrays instead of pointers where possible. Even as derived type components.

- Using recursive derived types, and pointer or allocatable components, and the `move_alloc` intrinsic  subroutine, one can create different data structures - e.g. `LIFO stacks with push and pop`, `linked lists` and `FIFO`.

- Allocatable arrays (and scalars with deferred type parameters such as variable length character), being allocated in heaps, can be automatically allocated with simple assignments, without calling allocate(). It also permits a simple extension of an existing allocatable array whose lower bounds are all 1. To add some extra values to such an integer array a of rank 1, it is sufficient to write, for example,
  `a = [ a, 5, 6 ]`. But you can't reallocate with allocate() without calling deallocate() first.

- **Deep-copying** for allocatable components of (recursive) derived types with **derived type assignment (=)** or **structure constructor**. **Shallow copying** when the component(s) is pointer instead of allocatable.

- Deallocating a recursive derived type structure with allocatable component deallocates all such components in the linked structures recursively.

- > The first step in using Fortran pointers is to determine the variables to which you will need to associate pointers. They must be given the TARGET attribute in a type statement.
  >
  > Why can't you associate Fortran pointers with any variable having the same type (as in C)? Maybe a cruel joke by the standards committee. More likely, another level of protection against programming errors, to limit the probability that a typo will associate a pointer with the wrong variable.
  >
  > -- John Mahaffy

<br>

### Format for double precision, kind type parameter, named constants

- Always try to use parameters instead of numeric values

- Either use `selected_real_kind()` or `real64` from the intrinsic `iso_fortran_env` module or

  ```fortran
  integer, parameter :: dp=kind(0.d0)
  real(dp), dimension(:) :: array=0._dp
  real(dp) :: scalar=0._dp !dot(.) is required if using _dp
  scalar=2 ! Integer can be assigned to float without losing accuracy
  ```

- > To print floating point double precision numbers without losing precision, use the `(es23.16)` format (see http://stackoverflow.com/questions/6118231/why-do-i-need-17-significant-digits-and-not-16-to-represent-a-double/).
  >
  > -- Ondrej Certik - fortran90.org - best practices

- See https://fortranwiki.org/fortran/show/Edit+descriptors to know what `es23.16` (scientific notation) means

  > The `F`, `E`, `EN`, `ES`, `D`, and `G` edit descriptors are used for editing real and complex items, with two such descriptors being required for each complex item. For input, all of the six descriptors are equivalent. For output, the `E`, `EN`, and `ES` descriptors produce both decimal and exponent parts. They differ in the number of digits written to the left of the decimal with `E` writing none, `ES` (scientific) writes one, and `EN` (engineering) writing one to three, such that the exponent is divisible by three. The `F` descriptor, on the other hand, writes a fixed number of digits without an exponent field. `D` is interchangeable with `E`. `G` will automatically choose between `F` and `E`.

<br>

### stderr

- Use intrinsic module for `error_unit` and dump errors to stderr.
- Exit with code is given by `stop <5 digit-code`. The `STOP` is written in stderr only.

<br>

### labels

3 digits at least for visibility

<br>

### named constructs and implied do

All constructs (e.g. **do**, **if**, **where**, **select**) can be named

```fortran
<name>: construct
...
end construct <name>
```

The `exit <name>` statement can, in fact, be used to complete the execution of any construct except the `do concurrent` construct. An `exit` statement without a construct name exits the innermost `do` construct.

`do ... if () exit ... end do` is better than `do while() end do`, as the conditional can be placed anywhere in the loop and the the portion before exit would always execute. `do while` is deprecated [Appendix A Metcalf, Reid, Cohen].

Similarly `cycle <name>`.

Use **implied do** and inline **where** and **if** where possible for speed.

<br>

### Pure, elemental functions preferred to subroutines with side-effects

Pure functions are easier to debug and maintain. Also compilers can optimize better - if they know a function is pure they may compute it in parallel. Always try to use pure functions if subroutines are unavoidable. Replace functions with side-effects with subroutines. Functions should ideally do only one task and do it well - Unix philosophy.

**Avoid *implicit save***: \**Do not initialize in declaration statements for procedures. This triggers implicit *save* which causes side-effects and performance penalty. Because of the side-effects also not allowed in pure procedures. Ok in main program and modules though.**

<br>

### `use <module>, only:` and `protected` attribute

If `only` is not used then,

1. if your program (or procedure) declares a variable with the same name as some entity that’s declared in the module, you may end up with a name conflict.
2. if your program (or procedure) references many different procedures and variables that were imported from a module, it’s difficult to see where the procedures and variables are defined just by looking at the code. This makes a program more difficult to understand and debug. As your application and library grow in size, and you import all entities from all modules implicitly, it becomes difficult to keep track of what came from what module, and there’s no way to find out until you look inside the modules for the declarations.

Declare all entities as private, and explicitly list those that are meant to be public.

Use renaming `use module, only: alias => original, ...`: **Use case example**: You have a weather prediction model defined in mod_atmosphere and an ocean prediction model defined in mod_ocean. Your job is to make them talk to each other as they simulate weather and ocean circulation. There’s just one problem: both mod_atmosphere and mod_ocean define an array called temperature.

**Modules need to be compiled before the program units that *use* them**

<br>

### Compiler version and options accessed at runtime

`use iso_fortran_env, only: compiler_version, compiler_options`

<br>

### Array constructor : set-roster or set-builder (implied-do)

roster: `real :: a(10)=[elemen1, element2, ...]`

builder: `real :: [(func(i),i=1,12)]`, or `[constant_independent_of_i, i=1,12]`

recursive type, pointer, allocatable, normal variable having desriptors

<br>

### Reshaping with array pointer

Array pointers can associate with target arrays of different ranks. Pointers can also alias for array slices, a.k.a subarrays a.k.a array sections.

<br>

### Accessor functions - Pointer functions denoting variables

May be used for storing key-value pairs - hash-table or dict.

Hash-table libraries/implementations: https://fortranwiki.org/fortran/show/Hash+tables

<br>

### Exception handling

`errstat`/`iostat`, `end`, `errmsg` specifiers in `allocate`, `deallocate`, `read` and `write` statements.

<br>

### I/O
Asynchronous I/O, Stream, Binary, Direct access for database, Sequential otherwise. Use `newunit` specifier in open.

**List-directed I/O is denoted by *: `print*,`**. Unformatted I/O is different: `write(nunit, iostat=ios, err=110)`.

`module iso_fortran_env, only: stdin => input_unit, stdout => output_unit, stderr => error_unit `

<br>

### `inquire` by file or unit

`inquire (file=fln, exist=ex)` by file to see if file exists before trying to open it. No trim(filename) needed for `file=` specifier. `inquire` returns UPPERCASE characters.

<br>

### Excellent Progress Bars, Build with Python and Cmake inspiration

https://github.com/szaghi/forbear

<br>

### Use submodules 

to hide `module procedure` implementations with the interface in the parent module.

<br>

### Useful intrinsic functions

`epsilon(x)` for checking convergence during iterations. `huge(x)` and `tiny(x)`. 

**Note: `epsilon` returns smallest value with only one significant number and no exponent (10^-7 for single precision and 10^-16 for double). `tiny` returns smallest possible value with exponent.**

`sqrt(real_dp)` will return `_dp`, no need to use `dsqrt` - `dsqrt` is deprecated rather. Similarly for `anint`.

`repeat(string, ncopies)`, `trim`, `len_trim`, `adjustl`, `adjustr`. No need to trim filename during open.

`index(string, substring, [back])`

`scan`, 

`transfer`, `mv_alloc`

`maxloc(array, mask)`, `minloc`, `findloc`, `maxval`, `minval`, `any`, `all`, `count`, `parity`, `merge`, `sum(array, mask)`, `product(array, mask)`

`hypot(x,y)`, `norm2(array)`

`cshift(array)`, `eoshift`

`dot_product`, `matmul`

**For array procedures check if specifying `dim` and `mask` are allowed**

**For double precision, using `kind=` in function argument, if needed. E.g. `real(int, kind=kind(0.d0))`**.

<br>

### Wall-clock/system-clock vs CPU time and CPU usage

Wclock: `call system_clock(int_count, int_or_real_count_rate, int_count_max)`

CPU-time: `call cpu_time(real_seconds)`

1. Always call the subroutines twice and determine difference to get the time.
2. 100*CPU-time-spent/wall-clock-time-spent gives CPU usage in percentage.

<br>

### `modulo` or `mod`?

Difference between these two is subtle. For positive integers they give the same results.

> As a rule of thumb, the sign of the result of MOD follows the sign of the
> numerator, the sign of the result of MODULO follows the sign of the
> denominator.
>
> For REALs, the definitions are the same (and the standard document
> does use the FLOOR function in the definition).
>
> If you require the remainder after integer division, MOD is what you
> use (because integer division is defined to truncate in Fortran).  If you're
> doing something else (like partitioning an array of values into bins) the
> MODULO function might better suit your needs since it has a more
> consistent behavior in the neighborhood of zero quotients.
>
> -- J. Giles - http://computer-programming-forum.com/49-fortran/8841595d70c918ba.htm

See their exact definitions in [MOD](https://gcc.gnu.org/onlinedocs/gfortran/MOD.html) and [MODULO](https://gcc.gnu.org/onlinedocs/gfortran/MODULO.html)

<br>

### Derived types for passing data to procedures

Imagine a force function/subroutine that requires a lot of input parameters. How to pass them all succinctly. Pass them as objects. For example if its a GB-GB interaction or GB well-depth+Spherocylinder-shape you have clear notions of objects. Each GB or Spherocylinder object carries its own parameters.

<br>

### Namelist
Simulations, for example, require a set of input parameters. The user specifies those in key-value format on a text file, and the code reads those in. **Namelist** provides the most natural way to handle this. The parameters belonging to a single category (or may be all parameters) are to be included in a single `namelist-group`. E.g. the force-field parameters may be included in **ff_params** as opposed to the thermodynamic parameters like thermostat temp and barostat press. The `read(filenum, nml=ff_params)` reads in the parameters from the key-value input file. Parameters may be specified in any order, in the input file, they may even appear more than once. Unspecified parameters would take the default values. So there must also be a default parameter input file somewhere to first initialise all parameters to their defaults before reading in the custom (user-specified) values. The parameter file may contain comments starting with `!`. Also, the input file may contain several more parameters from other namelist-groups. The `read(,nml=)` would ignore all those. Sample input file:
```
! Here there may be other key-value sets delimited by
! &namelist-group and /

&ff_params ! Start of ff_params set

param1 = value ! There may be space on either side of =
param2=valueA ! There may not be any space beside =

! There may be any amount of intervening blank lines

param2=valueB ! param2 would assume the latest value.
!etc...

/ ! End of ff_params set.

```
