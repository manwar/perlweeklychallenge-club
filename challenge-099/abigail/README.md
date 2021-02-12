# Solution by Abigail
## [Pattern Match](https://perlweeklychallenge.org/blog/perl-weekly-challenge-099/#TASK1)

You are given a string `$S` and a pattern `$P`.

Write a script to check if given pattern validate the entire string.
Print `1` if pass otherwise `0`.

The patterns can also have the following characters:
* ? - Match any single character.
* * - Match any sequence of characters.

### Examples
#### Example 1
~~~~
Input: $S = "abcde" $P = "a*e"
Output: 1
~~~~

#### Example 2
~~~~
Input: $S = "abcde" $P = "a*d"
Output: 0
~~~~

#### Example 3
~~~~
Input: $S = "abcde" $P = "?b*d"
Output: 0
~~~~

#### Example 4
~~~~
Input: $S = "abcde" $P = "a*c?e"
Output: 1
~~~~

### Notes
* We will be reading from standard input, one task perl line. We will
  assume the string and pattern are separated by a space.

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [C](c/ch-1.c)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* Perl
    * [Using regular expressions](perl/ch-1.pl)
    * [Recursion](perl/ch-1a.pl)
* [Python](python/ch-1.py)
* [Ruby](ruby/ch-1.rb)


## [Unique Subsequence](https://perlweeklychallenge.org/blog/perl-weekly-challenge-099/#TASK2)

You are given two strings `$S` and `$T`.

Write a script to find out count of different unique subsequences
matching `$T` without changing the position of characters.

### Examples
#### Example 1
~~~~
Input: $S = "littleit', $T = 'lit'
Output: 4

    1: [lit] tleit
    2: [li] t [t] leit
    3: [li] ttlei [t]
    4: litt [l] e [it]
~~~~

#### Example 2
~~~~
Input: $S = "london', $T = 'lon'
Output: 3

    1: [lon] don
    2: [lo] ndo [n]
    3: [l] ond [on]
~~~~
### Notes
* We will be reading from standard input, one task perl line. We will
  assume the string and pattern are separated by a space.

### Solutions
* [AWK](awk/ch-2.awk)
* [Bash](bash/ch-2.sh)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* Perl
    * [Using regular expressions](perl/ch-2.pl)
    * [Recursive counting](perl/ch-2a.pl)
* [Python](python/ch-2.py)
* [Ruby](ruby/ch-2.rb)

