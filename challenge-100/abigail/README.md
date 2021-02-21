# Solution by Abigail
## [Fun Time](https://perlweeklychallenge.org/blog/perl-weekly-challenge-100/#TASK1)

You are given a time (12 hour / 24 hour).

Write a script to convert the given time from 12 hour format to 24
hour format and vice versa.

Ideally we expect a one-liner.

### Examples
~~~~
Input: 05:15 pm or 05:15pm
Output: 17:15

Input: 19:15
Output: 07:15 pm or 07:15pm
~~~~

### Solutions
* [GNU AWK](awk/ch-1.gawk)
* [Bash](bash/ch-1.sh)
* [Befunge-93](befunge-93/ch-1.bf93)
* [C](c/ch-1.c)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [Ruby](ruby/ch-1.rb)

### Blog
[Perl Weekly Challenge 100: Fun Time](https://wp.me/pcxd30-qr)


## [Triangle Sum](https://perlweeklychallenge.org/blog/perl-weekly-challenge-100/#TASK2)

You are given triangle array.

Write a script to find the minimum path sum from top to bottom.

When you are on index `i` on the current row then you may move to
either index `i` or index `i + 1` on the next row.

### Examples
#### Example 1
~~~~
Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
Output: 8

Explanation: The given triangle

            1
           2 4
          6 4 9
         5 1 7 2

The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8

             [1]
           [2]  4
           6 [4] 9
          5 [1] 7 2
~~~~

#### Example 2
~~~~
Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
Output: 7

Explanation: The given triangle

            3
           3 1
          5 2 3
         4 3 1 3

The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7

             [3]
            3  [1]
           5 [2] 3
          4 3 [1] 3
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
[Perl Weekly Challenge 100: Triangle Sum](https://wp.me/pcxd30-qP)
