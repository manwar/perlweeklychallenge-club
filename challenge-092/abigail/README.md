# Solution by Abigail

## Task 1: Isomorphic Strings

You are given two strings `$A` and `$B`.

Write a script to check if the given strings are Isomorphic. Print
`1` if they are otherwise `0`.

### Examples
~~~~
Input: $A = "abc"; $B = "xyz"
Output: 1

Input: $A = "abb"; $B = "xyy"
Output: 1

Input: $A = "sum"; $B = "add"
Output: 0
~~~~

### Solutions
* [Perl](perl/ch-1.pl).


## Task 2: Insert Interval

You are given a set of sorted non-overlapping intervals and a new interval.

Write a script to merge the new interval to the given set of intervals.

### Examples
~~~~
Input $S = (1,4), (8,10); $N = (2,6)
Output: (1,6), (8,10)

Input $S = (1,2), (3,7), (8,10); $N = (5,8)
Output: (1,2), (3,10)

Input $S = (1,5), (7,9); $N = (10,11)
Output: (1,5), (7,9), (10,11)

### Solutions
* [Perl](perl/ch-2.pl).
