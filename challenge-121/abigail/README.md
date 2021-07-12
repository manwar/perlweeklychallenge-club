# Solutions by Abigail
## [Invert Bit][task1]

[task1]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-121/#TASK1

> You are given integers `0 <= $m <= 255` and `1 <= $n <= 8`.
>
> Write a script to invert `$n` bit from the end of the binary
> representation of `$m` and print the decimal representation of
> the new binary number.

### Examples
~~~~
Input: $m = 12, $n = 3
Output: 8
~~~~

* Binary representation of `$m = 00001100`
* Invert 3rd bit from the end `= 00001000`
* Decimal equivalent of `00001000 = 8`

~~~~
Input: $m = 18, $n = 4
Output: 26
~~~~

* Binary representation of `$m = 00010010`
* Invert 3rd bit from the end `= 00011010`
* Decimal equivalent of `00011010 = 26`


### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [bc](bc/ch-1.bc)
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
[Invert Bit][blog1]

## [The Travelling Salesman][task2]

> You are given a `NxN` matrix containing the distances between `N` cities.
>
> Write a script to find a round trip of minimum length visiting all `N`
> cities exactly once and returning to the start.

### Example
~~~~
Matrix: [0, 5, 2, 7]
        [5, 0, 5, 3]
        [3, 1, 0, 6]
        [4, 5, 4, 0]

Output:
        length = 10
        tour = (0 2 1 3 0)
~~~~

### Solutions

### Blog
[he Travelling Salesman][blog2]



[task1]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-121/#TASK1
[task1]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-121/#TASK2
[blog1]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-121-1.html
[blog2]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-121-2.html
