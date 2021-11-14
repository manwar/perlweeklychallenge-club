# Solutions by Abigail
## [Disjoint Sets][task1]

> You are given two sets with unique integers.
> 
> Write a script to figure out if they are disjoint.
> 
> > The two sets are disjoint if they don't have any common members.


### Examples

~~~~
Input: @S1 = (1, 2, 5, 3, 4)
       @S2 = (4, 6, 7, 8, 9)
~~~~

Output: `0` as the given two sets have common member `4`.

~~~~
Input: @S1 = (1, 3, 5, 7, 9)
       @S2 = (0, 2, 4, 6, 8)
~~~~

Output: `1` as the given two sets do not have common member.


### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [C](c/ch-1.c)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [Ruby](ruby/ch-1.rb)

### Blog
[Perl Weekly Challenge 127: Disjoint Sets][blog1]

## [Conflict Intervals][task2]

> You are given a list of intervals.
> 
> Write a script to find out if the current interval conflicts with
> any of the previous intervals.

### Examples

~~~~
Input: @Intervals = [(1,4), (3,5), (6,8), (12, 13), (3,20)]
Output: [(3,5), (3,20)]
~~~~

* The 1st interval `(1,4)` do not have any previous intervals to compare with,
  so skip it.
* The 2nd interval `(3,5)` does conflict with previous interval (1,4).
* The 3rd interval `(6,8)` do not conflicts with any of the previous intervals
  `(1,4)` and `(3,5)`, so skip it.
* The 4th interval `(12,13)` again do not conflicts with any of the previous
  intervals `(1,4)`, `(3,5)` and `(6,8)`, so skip it.
* The 5th interval `(3,20)` conflicts with the first interval `(1,4)`.

~~~~
Input: @Intervals = [(3,4), (5,7), (6,9), (10, 12), (13,15)]
Output: [(6,9)]
~~~~

* The 1st interval `(3,4)` do not have any previous intervals to compare with,
  so skip it.
* The 2nd interval `(5,7)` do not conflicts with the previous interval `(3,4)`,
  so skip it.
* The 3rd interval `(6,9)` does conflict with one of the previous
  intervals `(5,7)`.
* The 4th interval `(10,12)` do not conflicts with any of the previous
  intervals `(3,4)`, `(5,7)` and `(6,9)`, so skip it.
* The 5th interval `(13,15)` do not conflicts with any of the previous
  intervals `(3,4)`, `(5,7)`, `(6,9)` and `(10,12)`, so skip it.

### Solutions
* [AWK](awk/ch-2.awk)
* [Perl](perl/ch-2.pl)

### Blog
[Perl Weekly Challenge 127: Conflict Intervals][blog2]



[task1]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-127/#TASK1
[task2]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-127/#TASK2
[blog1]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-127-1.html
[blog2]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-127-2.html
