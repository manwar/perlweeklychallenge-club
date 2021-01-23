# Solution by Abigail

## [Reverse Words](https://perlweeklychallenge.org/blog/perl-weekly-challenge-096/#TASK1)

You are given a string `$S`.

Write a script to reverse the order of words in the given string.
The string may contain leading/trailing spaces. The string may have
more than one space between words in the string. Print the result
without leading/trailing spaces and there should be only one space
between words.

### Examples
~~~~
Input: $S = "The Weekly Challenge"
Output: "Challenge Weekly The"

Input: $S = "    Perl and   Raku are  part of the same family  "
Output: "family same the of part are Raku and Perl"
~~~~

### Notes

The challenge isn't quite clear on whether we should output a number
(the minimal number of operations required), or the actual operations.
The examples show both -- but separated by a blank line. Previous
challenges typically use a blank line to separate the required output
from the explaination on why that it is the correct answer.

We're opting to only print the number of operations, not the actual
operations.

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](sh/ch-1.sh)
* [C](c/ch-1.c)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [Ruby](ruby/ch-1.rb)

### Blog
[Perl Weekly Challenge 96: Reverse Words](https://wp.me/pcxd30-mj)


## [Edit Distance](https://perlweeklychallenge.org/blog/perl-weekly-challenge-096/#TASK2)

You are given two strings `$S1` and `$S2`.

Write a script to find out the minimum operations required to convert
`$S1` into `$S2`. The operations can be insert, remove or replace a
character. Please check out [Wikipedia
page](https://en.wikipedia.org/wiki/Edit_distance) for more information.

### Example
~~~~
Input: $S1 = "kitten"; $S2 = "sitting"
Output: 3

Operation 1: replace 'k' with 's'
Operation 2: replace 'e' with 'i'
Operation 3: insert 'g' at the end
~~~~

~~~~
Input: $S1 = "sunday"; $S2 = "monday"
Output: 2

Operation 1: replace 's' with 'm'
Operation 2: replace 'u' with 'o'
~~~~

### Solutions
* [AWK](awk/ch-2.awk)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)
* [Ruby](ruby/ch-2.rb)

### Blog
[Perl Weekly Challenge 96: Edit Distance](https://wp.me/pcxd30-n7)
