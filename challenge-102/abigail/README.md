# Solution by Abigail
## [Rare Numbers](https://perlweeklychallenge.org/blog/perl-weekly-challenge-102/#TASK1)


You are given a positive integer `$N`.

Write a script to generate all Rare numbers of size `$N` if exists.
Please checkout [the page](http://www.shyamsundergupta.com/rare.htm)
for more information about it.

### Examples
~~~~
(a) 2 digits: 65
(b) 6 digits: 621770
(c) 9 digits: 281089082
~~~~

### Notes

There is no simple efficient algorithm for spitting out rare numbers;
at least not one which can be easily found online.

The code fragments in the OEIS only give code to check whether a 
number is a rare number, and they don't suggest anything other
than "try all numbers" if you want to find all of the numbers of a
certain length. 

Shyam writes: [*I have developed a computer program in Fortran to
calculate Rare numbers. In fact with refinement of the code over
the years, the program has been made so powerful that all numbers
up to 10^14 can be just checked for Rare numbers in less than a
minute on Pentium III PC. In few hours I have been able to check
up to 10^18.*](https://www.primepuzzles.net/conjectures/conj_023.htm)
but he does not publish his code.

Richard Guy writes [*Here are three problems that have come to light
recently, each of which can consume unlimited amounts of computer time,
perhaps without revealing anything
significant*.](https://www.jstor.org/stable/2325149?seq=1)
The rare numbers are one of the three problems.

So, we just include a [list of all know rare numbers,
up to 10^22](https://oeis.org/A035519/b035519.txt) 
and preprocess them so they're bucketed to length. Then it's just
a matter of reading the desired length, and printing the appropriate
entry (or the empty string if no rare numbers of that length exist).
There are only 124 known rare numbers, so preprocessing is very
feasible.


### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [BASIC](basic/ch-1.bas)
* [C](c/ch-1.c)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [Ruby](ruby/ch-1.rb)

### Blog
[Perl Weekly Challenge 102: Rare Numbers](https://wp.me/pcxd30-t7)


## [Hash-counting String](https://perlweeklychallenge.org/blog/perl-weekly-challenge-102/#TASK2)

You are given a positive integer `$N`.

Write a script to produce Hash-counting string of that length.

The definition of a hash-counting string is as follows:
- the string consists only of digits 0-9 and hashes, `'#'`.
- there are no two consecutive hashes: `"##"z does not appear in your string
- the last character is a hash
- the number immediately preceding each hash (if it exists) is the position
  of that hash in the string, with the position being counted up from 1

It can be shown that for every positive integer `N` there is exactly one
such length-`N` string.

### Examples
~~~~
(a) "#" is the counting string of length 1
(b) "2#" is the counting string of length 2
(c) "#3#" is the string of length 3
(d) "#3#5#7#10#" is the string of length 10
(e) "2#4#6#8#11#14#" is the string of length 14
~~~~

### Solutions
* [AWK](awk/ch-2.awk)
* [Bash](bash/ch-2.sh)
* [Befunge-93](befunge-93/ch-2.bf93)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)
* [Ruby](ruby/ch-2.rb)
