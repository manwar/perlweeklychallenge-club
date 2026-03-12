Challenge 255
https://theweeklychallenge.org/blog/perl-weekly-challenge-255/

Task 1: Odd Character
Submitted by: Mohammad Sajid Anwar
You are given two strings, $s and $t. The string $t is generated using the shuffled characters of the string $s with an additional character.

Write a script to find the additional character in the string $t..

Example 1
Input: $s = "Perl" $t = "Preel"
Output: "e"

Example 2
Input: $s = "Weekly" $t = "Weeakly"
Output: "a"

Example 3
Input: $s = "Box" $t = "Boxy"
Output: "y"


Task 2: Most Frequent Word
Submitted by: Mohammad Sajid Anwar
You are given a paragraph $p and a banned word $w.

Write a script to return the most frequent word that is not banned.

Example 1
Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
       $w = "hit"
Output: "ball"

The banned word "hit" occurs 3 times.
The other word "ball" occurs 2 times.

Example 2
Input: $p = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge."
       $w = "the"
Output: "Perl"

The banned word "the" occurs 3 times.
The other word "Perl" occurs 2 times.
