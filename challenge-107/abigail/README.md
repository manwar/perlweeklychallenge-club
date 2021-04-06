# Solution by Abigail
## [Self-descriptive Numbers](https://perlweeklychallenge.org/blog/perl-weekly-challenge-107/#TASK1)

Write a script to display the first three self-descriptive numbers.
As per [wikipedia](https://en.wikipedia.org/wiki/Self-descriptive_number),
the definition of Self-descriptive Number is

> In mathematics, a self-descriptive number is an integer `m` that in a
> given base `b` is `b` digits long in which each digit `d` at position `n`
> (the most significant digit being at position 0 and the least
> significant at position `b - 1`) counts how many instances of
> digit `n` are in `m`.

### Example
~~~~
 1210 is a four-digit self-descriptive number:

    position 0 has value 1 i.e. there is only one 0 in the number
    position 1 has value 2 i.e. there are two 1 in the number
    position 2 has value 1 i.e. there is only one 2 in the number
    position 3 has value 0 i.e. there is no 3 in the number
~~~~

### Output
~~~~
    1210, 2020, 21200
~~~~

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.awk)
* [BASIC](basic/ch-1.bas)
* [bc](bc/ch-1.bc)
* [Befunge-93](befunge-93/ch-1.bf93)
* [C](c/ch-1.c)
* [Cobol](cobol/ch-1.cb)
* [Csh](csh/ch-1.csh)
* [Erlang](erlang/ch-1.erl)
* [Forth](forth/ch-1.fs)
* [Fortran](fortran/ch-1.fs)
* [Go](go/ch-1.go)
* [Java](java/ch-1.java)
* [Lua](lua/ch-1.lua)
* [m4](m4/ch-1.m4)
* [Node.js](lua/ch-1.js)
* [OCaml](ocaml/ch-1.ml)
* [Pascal](pascal/ch-1.pl)
* [Perl](perl/ch-1.pl)
* [PHP](php/ch-1.pl)
* [Python](python/ch-1.py)
* [R](r/ch-1.r)
* [Rexx](rexx/ch-1.rexx)
* [Ruby](ruby/ch-1.rb)
* [Scheme](scheme/ch-1.scm)
* [sed](sed/ch-1.sed)
* [SQL](sql/ch-1.sql)
* [Tcl](tcl/ch-1.tcl)

### Blog

## [List Methods](https://perlweeklychallenge.org/blog/perl-weekly-challenge-107/#TASK2)

Write a script to list methods of a package/class.

### Example
Given the package:
~~~~
package Calc;

use strict;
use warnings;

sub new { bless {}, shift; }
sub add { }
sub mul { }
sub div { }

1;
~~~~
Output:
~~~~
BEGIN
mul
div
new
add
~~~~

### Solutions

### Blog

