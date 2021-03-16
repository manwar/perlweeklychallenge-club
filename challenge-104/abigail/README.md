# Solution by Abigail
## [FUSC Sequence](https://perlweeklychallenge.org/blog/perl-weekly-challenge-104/#TASK1)

Write a script to generate first 50 members of FUSC Sequence. Please
refer to [OEIS](https://oeis.org/A002487) for more information._

The sequence defined as below:

~~~~
fusc(0) = 0
fusc(1) = 1
for n > 1:
when n is even: fusc(n) = fusc(n / 2),
when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)
~~~~

### Notes
This challenge is beyond simple. Since we're asked to generate a
fixed number of numbers, we don't need do any calculations, or
even handle a single if statement. A single print statement is enough.

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [Basic](basic/ch-1.bas)
* [Befunge-93](befunge-93/ch-1.bf93)
* [bc](bc/ch-1.bc)
* [C](c/ch-1.c)
* [Cobol](cobol/ch-1.cb)
* [Forth](forth/ch-1.fs)
* [Fortran](fortran/ch-1.f90)
* [Go](go/ch-1.go)
* [Java](java/ch-1.java)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Pascal](perl/ch-1.p)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [R](r/ch-1.r)
* [Ruby](ruby/ch-1.rb)
* [Scheme](scheme/ch-1.scm)
* [SQL](sql/ch-1.sql)
* [Tcl](tcl/ch-1.tcl)

### Blog


## [NIM Game](https://perlweeklychallenge.org/blog/perl-weekly-challenge-104/#TASK2)
Write a script to simulate the NIM Game.

It is played between 2 players. For the purpose of this task, let
assume you play against the machine.

There are 3 simple rules to follow:
~~~~
a) You have 12 tokens
b) Each player can pick 1, 2 or 3 tokens at a time
c) The player who picks the last token wins the game
~~~~

### Notes
This is *not* the well known NIM game. In the NIM game, you have multiple sets
of tokens, and on each turn, a player picks a set, and removes any
non-zero number of of tokens from the set. Typically, the player
picking the last token loses.

The game as given is sometimes also known as the NIM game, but it better
known as the subtraction game. With the given parameters and perfect
play, the second player always wins on the third move.

### Solutions
* [Perl](perl/ch-2.pl)

### Blog
