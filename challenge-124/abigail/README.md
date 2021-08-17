# Solutions by Abigail
## [Happy Women Day][task1]

> Write a script to print the Venus Symbol, international gender symbol
> for women. Please feel free to use any character.

~~~~
    ^^^^^
   ^     ^
  ^       ^
 ^         ^
 ^         ^
 ^         ^
 ^         ^
 ^         ^
  ^       ^
   ^     ^
    ^^^^^
      ^
      ^
      ^
    ^^^^^
      ^
      ^
~~~~

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [Basic](basic/ch-1.bas)
* [bc](bc/ch-1.bc)
* [Befunge-93](befunge-93/ch-1.bf93)
* [C](c/ch-1.c)
* [Cobol](cobol/ch-1.cb)
* [Csh](csh/ch-1.csh)
* [Erlang](erlang/ch-1.erl)
* [Forth](forth/ch-1.fs)
* [Fortran](fortran/ch-1.f90)
* [Go](go/ch-1.go)
* [Java](java/ch-1.java)
* [Lua](lua/ch-1.lua)
* [m4](m4/ch-1.m4)
* [MMIX](mmix/ch-1.mms)
* [Node.js](node/ch-1.js)
* [Ocaml](ocaml/ch-1.ml)
* [Pascal](pascal/ch-1.p)
* [Perl](perl/ch-1.pl)
* [Php](php/ch-1.php)
* [Postscript](postscript/ch-1.ps)
* [Python](python/ch-1.py)
* [R](r/ch-1.r)
* [Rexx](rexx/ch-1.rexx)
* [Ruby](ruby/ch-1.rb)
* [Scheme](scheme/ch-1.scm)
* [SQL](sql/ch-1.sql)
* [Tcl](tcl/ch-1.tcl)

### Blog
[Perl Weekly Challenge 124: Happy Women Day][blog1]

## [Tug of War][task2]

> You are given a set of $n integers `(n1, n2, n3, ...)`.
>
> Write a script to divide the set in two subsets of `n/2` sizes each
> so that the difference of the sum of two subsets is the least. If
> `$n` is even then each subset must be of size `$n/2` each. In case $n
> is odd then one subset must be `($n-1)/2` and other must be `($n+1)/2`.

### Examples
~~~~
Input:        Set = (10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
Output:  Subset 1 = (30, 40, 60, 70, 80)
         Subset 2 = (10, 20, 50, 90, 100)
~~~~

~~~~
Input:        Set = (10, -15, 20, 30, -25, 0, 5, 40, -5)
         Subset 1 = (30, 0, 5, -5)
         Subset 2 = (10, -15, 20, -25, 40)
~~~~

### Solutions
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)

### Blog
[Perl Weekly Challenge 124: Tug of War][blog2]



[task1]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-124/#TASK1
[task2]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-124/#TASK2
[blog1]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-124-1.html
[blog2]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-124-2.html
