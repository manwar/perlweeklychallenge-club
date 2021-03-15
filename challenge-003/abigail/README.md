# Solution by Abigail

## [Challenge #1](https://perlweeklychallenge.org/blog/perl-weekly-challenge-003/#challenge-1)
Create a script to generate `5`-smooth numbers, whose prime divisors
are less or equal to `5`. They are also called Hamming/Regular/Ugly
numbers. For more information, please check this
[wikipedia](https://en.wikipedia.org/wiki/Regular_number).

### Notes
We are going to generate all numbers `n = 2^i * 3^j * 5^k`, with
`i >= 0`, `j >= 0`, `k >= 0`, and `n <= MAX`, where `MAX` is read
from `STDIN`. No other numbers are generated.

We are *not* going to generate the numbers `n` in
numerical order. Instead, if we have two numbers `n1 = 2^i1 * 3^j1 * 5^k1`,
and `n2 = 2^i2 * 3^j2 * 5^k2`, then `n1` is generated before `n2`, iff

    i1 <  i2                         ||
    i1 == i2 && j1 <  j2             ||
    i1 == i2 && j1 == j2 && k1 <  k2

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [bc](bc/ch-1.bc)
* [C](c/ch-1.c)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [Ruby](ruby/ch-1.rb)


## [Challenge #2](https://perlweeklychallenge.org/blog/perl-weekly-challenge-003/#challenge-2)
Create a script that generates Pascal Triangle. Accept number of
rows from the command line. The Pascal Triangle should have at least
3 rows. For more information about Pascal Triangle, check this
[wikipedia](https://en.wikipedia.org/wiki/Pascal%27s_triangle) page.

### Solutions
* [AWK](awk/ch-2.awk)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)
* [Ruby](ruby/ch-2.rb)
