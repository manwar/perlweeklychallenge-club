# Solutions by Abigail
## [Missing Row](https://perlweeklychallenge.org/blog/perl-weekly-challenge-117/#TASK1)

> You are given text file with rows numbered `1-15` in random order but
> there is a catch one row in missing in the file.

~~~~
11, Line Eleven
1, Line one
9, Line Nine
13, Line Thirteen
2, Line two
6, Line Six
8, Line Eight
10, Line Ten
7, Line Seven
4, Line Four
14, Line Fourteen
3, Line three
15, Line Fifteen
5, Line Five
~~~~

Write a script to find the missing row number.

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
[Missing Row](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-117-1.html)

## [Find Possible Paths](https://perlweeklychallenge.org/blog/perl-weekly-challenge-115/#TASK2)

> You are given size of a triangle.
> 
> Write a script to find all possible paths from top to the bottom
> right corner.
> 
> In each step, we can either move horizontally to the right (`H`), or
> move downwards to the left (`L`) or right (`R`).
>
> BONUS: Try if it can handle triangle of size `10` or `20`.

### Examples
~~~~
Input: $N = 2

           S
          / \
         / _ \
        /\   /\
       /__\ /__\ E

Output: RR, LHR, LHLH, LLHH, RLH, LRH
~~~~

~~~~
Input: $N = 1

           S
          / \
         / _ \ E

Output: R, LH
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
[Find Possible Paths](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-117-2.html)
