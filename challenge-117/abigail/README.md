# Solutions by Abigail
## [Number Sequence](https://perlweeklychallenge.org/blog/perl-weekly-challenge-116/#TASK1)

> You are given a number `$N` >= `10`.
> 
> Write a script to split the given number such that the difference
> between two consecutive numbers is always 1 and it shouldn't have
> leading `0`.
> 
> Print the given number if it impossible to split the number.

### Example
~~~~
Input: $N = 1234
Output: 1,2,3,4

Input: $N = 91011
Output: 9,10,11

Input: $N = 10203
Output: 10203 as it is impossible to split satisfying the conditions.
~~~~

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [Ruby](ruby/ch-1.rb)

### Blog
[Number Sequence](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-116-1.html)

## [Sum of Squares](https://perlweeklychallenge.org/blog/perl-weekly-challenge-115/#TASK2)

> You are given a number $N >= 10.
>
> Write a script to find out if the given number `$N` is such that
> sum of squares of all digits is a perfect square.
> Print `1` if it is otherwise `0`.

### Examples
~~~~
Input: $N = 34
Ouput: 1 as 3^2 + 4^2 => 9 + 16 => 25 => 5^2

Input: $N = 50
Output: 1 as 5^2 + 0^2 => 25 + 0 => 25 => 5^2

Input: $N = 52
Output: 0 as 5^2 + 2^2 => 25 + 4 => 29
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
[Sum of Squares](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-116-2.html)
