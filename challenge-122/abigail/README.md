# Solutions by Abigail
## [Average of Stream][task1]

> You are given a stream of numbers, `@N`.
>
> Write a script to print the average of the stream at every point.

### Example
~~~~
Input: @N = (10, 20, 30, 40, 50, 60, 70, 80, 90, ...)
Output:      10, 15, 20, 25, 30, 35, 40, 45, 50, ...
~~~~

* Average of first number is `10`.
* Average of first 2 numbers `(10+20)/2 = 15`.
* Average of first 3 numbers `(10+20+30)/3 = 20`.
* Average of first 4 numbers `(10+20+30+40)/4 = 25` and so on.

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [bc](bc/ch-1.bc)
* [Befunge-93](befunge-93/ch-1.bf)
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
[Average of Stream][blog1]

## [Basketball Points][task2]

> You are given a score `$S`.
> 
> You can win basketball points e.g. `1` point, `2` points and `3` points.
>
> Write a script to find out the different ways you can score `$S`.

### Examples
~~~~
Input: $S = 4
Output: 1 1 1 1
        1 1 2
        1 2 1
        1 3
        2 1 1
        2 2
        3 1
~~~~

~~~~
Input: $S = 5
Output: 1 1 1 1 1
        1 1 1 2
        1 1 2 1
        1 1 3
        1 2 1 1
        1 2 2
        1 3 1
        2 1 1 1
        2 1 2
        2 2 1
        2 3
        3 1 1
        3 2
~~~~

### Solutions
* [AWK](awk/ch-2.awk)
* [Bash](bash/ch-2.sh)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)
* [Ruby](ruby/ch-2.rb)

### Blog
[Basketball Points][blog2]



[task1]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-122/#TASK1
[task1]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-122/#TASK2
[blog1]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-122-1.html
[blog2]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-122-2.html
