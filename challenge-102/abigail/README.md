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

### Solutions
* [AWK](awk/ch-1.awk)
* [Perl](perl/ch-1.pl)


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
