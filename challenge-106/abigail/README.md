# Solution by Abigail
## [Maximum Gap](https://perlweeklychallenge.org/blog/perl-weekly-challenge-106/#TASK1)

You are given an array of integers `@N`.

Write a script to display the maximum difference between two
successive elements once the array is sorted.

If the array contains only `1` element then display `0`.

### Examples
~~~~
Input: @N = (2, 9, 3, 5)
Output: 4

Input: @N = (1, 3, 8, 2, 0)
Output: 5

Input: @N = (5)
Output: 0
~~~~

### Solutions
* [GNU AWK](awk/ch-1.gawk)
* [Bash](perl/ch-1.sh)
* [C](c/ch-1.c)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [Ruby](ruby/ch-1.rb)

### Blog
[]()

## [Decimal String](https://perlweeklychallenge.org/blog/perl-weekly-challenge-106/#TASK2)

You are given numerator and denominator i.e. `$N` and `$D`.

Write a script to convert the fraction into decimal string. If the
fractional part is recurring then put it in parenthesis.

### Examples
~~~~
Input: $N = 1, $D = 3
Output: "0.(3)"

Input: $N = 1, $D = 2
Output: "0.5"

Input: $N = 5, $D = 66
Output: "0.0(75)"
~~~~

### Notes

We're creation the decimal expansion of the fraction `$N / $D`
by performing long division.

First, we calculate the part before the decimal point, by
doing integer division of `$N / $D`.
We're then left to do division of `$N' / $D`, where `$N'` initially
is `$N % $D`.
We then repeatedly find new digits by calculating the integer
division of `(10 * $N' / $D)` (which gives us a new digit in the
decimal expansion), and then setting `$N' = 10 * $N' % $D`.
The fraction will have a finite decimal expansion if during the
process `$N'` becomes `0`. Otherwise, it repeats, and it repeats
as soon as have a `$N'` which we've already seen. By the pidgeon
hole principle, this cannot take more then $D steps.
To calculate the repeating part, we keep track of how far we
were in calculating the expansion for which `$N'`.

~~~~
     22/7     \0.318
        0                      int (7 / 22) == 0, so 0 before decimal point
        --
        7                      N =       N  % D
        66                     3 * D
        --
         4                     N = (10 * N) % D   <--+
         22                    1 * D                 |
         --                                          |  Same, so '18'
         18                    N = (10 * N) % D      |  is the repeating
         176                   8 * D                 |  part
         ---                                         |
           4                   N = (10 * N) % D   <--+
~~~~

This implementation is based on the [one given on
Wikipedia](https://en.wikipedia.org/wiki/Repeating_decimal).


### Solutions
* [AWK](perl/ch-2.awk)
* [Bash](bash/ch-2.sh)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Perl](perl/ch-2.pl)

### Blog
[]()
