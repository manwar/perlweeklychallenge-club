# Solutions by Asbigail
## [Chowla Numbers](https://perlweeklychallenge.org/blog/perl-weekly-challenge-109/#TASK1)

Write a script to generate first 20 Chowla Numbers, named after,
Sarvadaman D. S. Chowla, a London born Indian American mathematician.
It is defined as:

    C(n) = (sum of divisors of n) - 1 - n

### Output

    0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [BASIC](basic/ch-1.bas)
* [bc](bc/ch-1.bc)
* [Befunge-93][befunge-93/ch-1.bf93]
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
* [Node.js](node/ch-1.js)
* [Ocaml](ocaml/ch-1.ml)
* [Pascal](pascal/ch-1.p)
* [Perl](perl/ch-1.pl)
* [PHP](php/ch-1.php)
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


## [Four Squares Puzzle](https://perlweeklychallenge.org/blog/perl-weekly-challenge-109/#TASK2)

You are given four squares as below with numbers named `a`, `b`,
`c`, `d`, `e`, `f`, `g`.

              (1)                    (3)
        ╔══════════════╗      ╔══════════════╗
        ║              ║      ║              ║
        ║      a       ║      ║      e       ║
        ║              ║ (2)  ║              ║  (4)
        ║          ┌───╫──────╫───┐      ┌───╫─────────┐
        ║          │   ║      ║   │      │   ║         │
        ║          │ b ║      ║ d │      │ f ║         │
        ║          │   ║      ║   │      │   ║         │
        ║          │   ║      ║   │      │   ║         │
        ╚══════════╪═══╝      ╚═══╪══════╪═══╝         │
                   │       c      │      │      g      │
                   │              │      │             │
                   │              │      │             │
                   └──────────────┘      └─────────────┘

Write a script to place the given unique numbers in the square box
so that sum of numbers in each box is the same.

### Example

~~~~
Input: 1,2,3,4,5,6,7

Output:

    a = 6
    b = 4
    c = 1
    d = 5
    e = 2
    f = 3
    g = 7

    Box 1: a + b = 6 + 4 = 10
    Box 2: b + c + d = 4 + 1 + 5 = 10
    Box 3: d + e + f = 5 + 2 + 3 = 10
    Box 4: f + g = 3 + 7 = 10
~~~~

### Solutions
* [AWK](awk/ch-2.awk)
* [Bash](bash/ch-2.sh)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Perl](perl/ch-2.pl)

### Blog

