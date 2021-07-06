# Solutions by Abigail
## [Swap Odd/Even Bits](https://perlweeklychallenge.org/blog/perl-weekly-challenge-120/#TASK1)

> You are given a positive integer `$N` less than or equal to 255.
> 
> Write a script to swap the odd positioned bit with even positioned
> bit and print the decimal equivalent of the new binary representation.

### Examples
~~~~
Input: $N = 101
Output: 154
~~~~

Binary representation of the given number is `01 10 01 01`.
The new binary representation after the odd/even swap is `10 01 10 10`.
The decimal equivalent of `10011010` is `154`.

~~~~
Input: $N = 18
Output: 33
~~~~

Binary representation of the given number is `00 01 00 10`.
The new binary representation after the odd/even swap is `00 10 00 01`.
The decimal equivalent of `100001` is `33`.

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [bc](bc/ch-1.bc)
* [Befunge-93](befunge-93/ch-1.bf93)
* [C](c/ch-1.c)
* [Go](go/ch-1.go)
* [Java](java/ch-1.java)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Pascal](pascal/ch-1.p)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [R](r/ch-1.r)
* [Ruby](ruby/ch-1.rb)
* [Scheme](scheme/ch-1.scm)
* [Tcl](tcl/ch-1.tcl)

### Blog
[Swap Odd/Even Bits](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-120-1.html)

## [Clock Angle](https://perlweeklychallenge.org/blog/perl-weekly-challenge-119/#TASK2)

> You are given time `$T` in the format `hh:mm`.
>
> Write a script to find the smaller angle formed by the hands of an
> analog clock at a given time.<br>
> **HINT: A analog clock is divided up into `12` sectors. One sector
> represents `30` degree (`360/12 = 30`).**

### Examples
~~~~
Input: $T = '03:10'
Output: 35 degree
~~~~

The distance between the `2` and the `3` on the clock is `30` degree.
For the `10` minutes i.e. `1/6` of an hour that have passed.  The hour
hand has also moved `1/6` of the distance between the `3` and the `4`,
which adds `5` degree (`1/6` of `30`).  The total measure of the angle
is `35` degree.

~~~~
Input: $T = '04:00'
Output: 120 degree
~~~~

### Solutions
* [AWK](awk/ch-2.awk)
* [Bash](bash/ch-2.sh)
* [bc](bc/ch-2.bc)
* [Befunge-93](befunge-93/ch-2.bf93)
* [C](c/ch-2.c)
* [Go](go/ch-2.go)
* [Java](java/ch-2.java)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)
* [R](r/ch-2.r)
* [Ruby](ruby/ch-2.rb)
* [Tcl](tcl/ch-2.tcl)

### Blog
[Clock Angle](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-120-2.html)
