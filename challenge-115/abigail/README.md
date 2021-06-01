# Solutions by Abigail
## [String Chain](https://perlweeklychallenge.org/blog/perl-weekly-challenge-115/#TASK1)

> You are given an array of strings.
> 
> Write a script to find out if the given strings can be chained
> to form a circle. Print `1` if found otherwise `0`.
>
> > A string `$S` can be put before another string `$T` in circle
> > if the last character of `$S` is same as first character of `$T`.

### Example
~~~~
Input: @S = ("abc", "dea", "cd")
Output: 1 as we can form circle e.g. "abc", "cd", "dea".

Input: @S = ("ade", "cbd", "fgh")
Output: 0 as we can't form circle.
~~~~

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
[String Chain](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-115-1.html)

## [Largest Multiple](https://perlweeklychallenge.org/blog/perl-weekly-challenge-115/#TASK2)

> You are given a list of positive integers `(0-9)`, single digit.
>
> Write a script to find the largest multiple of `2` that can be
> formed from the list.

### Examples
~~~~
Input: @N = (1, 0, 2, 6)
Output: 6210

Input: @N = (1, 4, 2, 8)
Output: 8412

Input: @N = (4, 1, 7, 6)
Output: 7614
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
[String Chain](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-115-2.html)
