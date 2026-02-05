Challenge 349
https://theweeklychallenge.org/blog/perl-weekly-challenge-349/

Task 1: Power String
Submitted by: Mohammad Sajid Anwar
You are given a string.

Write a script to return the power of the given string.

The power of the string is the maximum length of a non-empty substring that contains only one unique character.


Example 1
Input: $str = "textbook"
Output: 2

Breakdown: "t", "e", "x", "b", "oo", "k"
The longest substring with one unique character is "oo".

Example 2
Input: $str = "aaaaa"
Output: 5

Example 3
Input: $str = "hoorayyy"
Output: 3

Breakdown: "h", "oo", "r", "a", "yyy"
The longest substring with one unique character is "yyy".

Example 4
Input: $str = "x"
Output: 1

Example 5
Input: $str = "aabcccddeeffffghijjk"
Output: 4

Breakdown: "aa", "b", "ccc", "dd", "ee", "ffff", "g", "h", "i", "jj", "k"
The longest substring with one unique character is "ffff".

Task 2: Meeting Point
Submitted by: Mohammad Sajid Anwar
You are given instruction string made up of U (up), D (down), L (left) and R (right).

Write a script to return true if following the instruction, you meet (0,0) at any point along the sequence.


Example 1
Input: $path = "ULD"
Output: false

(-1,1) <- (0,1)
   |        ^
   v        |
(-1,0)    (0,0)

Example 2
Input: $path = "ULDR"
Output: true

 (-1,1) <- (0,1)
    |        ^
    v        |
 (-1,0) -> (0,0)

Example 3
Input: $path = "UUURRRDDD"
Output: false

(0,3) -> (1,3) -> (2,3) -> (3,3)
  ^                          |
  |                          v
(0,2)                      (3,2)
  ^                          |
  |                          v
(0,1)                      (3,1)
  ^                          |
  |                          v
(0,0)                      (3,0)

Example 4
Input: $path = "UURRRDDLLL"
Output: true

(0,2) -> (1,2) -> (2,2) -> (3,2)
  ^                          |
  |                          v
(0,1)                      (3,1)
  ^                          |
  |                          v
(0,0) <- (1,0) <- (1,1) <- (3,0)

Example 5
Input: $path = "RRUULLDDRRUU"
Output: true

(0,2) <- (1,2) <- (2,2)
  |                 ^
  v                 |
(0,1)             (2,1)
  |                 ^
  v                 |
(0,0) -> (1,0) -> (2,1)
