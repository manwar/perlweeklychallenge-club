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

### Notes

This is a trivial exercise -- as all exercises are which do not
take any input, and which have a fixed output. Fixed output
challenges are boring -- unless there's another condition (golf,
for instance).

This exercise is so trivial, we don't even have to head to the OEIS
to download the wanted numbers, as the expected output is stated
in the exercise.

So, all we need to do is print three numbers, separated by commas.

The easiest way would be to just do what the challenge demands
from us, and print the output as given.

A slightly less easy way would be to head over the given
[Wikipedia page](https://en.wikipedia.org/wiki/Self-descriptive_number)
(or the [OEIS](https://oeis.org) for that matter), copy the first
three numbers, and print those out.

But those solutions no doubt will cause scorn in two weeks,
when the review comes out. It's all "advice about the code is the thing".

But that raises the question, what is the code which is wanted? 
You could generate all the numbers of length `b` in base `b`, while
increasing `b`, test them for being self-descriptive, and print 
the first three numbers found.

My advice about brute force code when there is a more efficient way:
Don't ever do that.

If we just imagine the Wikipedia page didn't list any self-descriptive
numbers, and Neil Sloane has forgotten to pay the fee for the OEIS
domain, so it was taken off-line, then it's still easy to determine
the first three self-descriptive numbers -- no code required.

Given the following observations for a self-descriptive number `N` in base `b`:
* `N` has `b` digits, and does not start with a `0`.
* The sum of the digits of `N` is `b`.
* No digit of `N` equals `b - 1`.
* The last digit of `N` is `0`.
* If `b > 4`, then `N` does not start with a `1`.
* If `b > 4`, then `N` does not start with `b - 2`.

From that, it's easy to determine that:
* There are no self-descriptive numbers in any base below `4`.
* A self-descriptive number in base `4` must start with a `1` or `2`. And
  end with a `0`. If it starts with a `1`, the middle digits are `1` and `2`.
  If it starts with a `2`, the middle digits are `0` and `2`. Both `1210`,
  and `2020"`are self-descriptive numbers.
* A self-descriptive number in base `5` must start with a `2`, and end
  with a `0`. The three middle digits must be `0`, `1`, and `2`. `21200`
  is a self-descriptive number.

(For a more detailed derivation, with all the details filled in, see [the blog
post](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-107-1.html))

But this still makes this challenge a glorified `Hello, World!`
program, as there is no useful code to write to generate the numbers.

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
* [PostScript](postscript/ch-1.ps)
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
* [Perl](perl/ch-2.pl)

### Blog

