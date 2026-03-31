Perl Weekly Challenge 190
https://theweeklychallenge.org/blog/perl-weekly-challenge-190/

Task 1: Capital Detection
Submitted by: Mohammad S Anwar
You are given a string with alphabetic characters only: A..Z and a..z.

Write a script to find out if the usage of Capital is appropriate if it satisfies at least one of the following rules:

1) Only first letter is capital and all others are small.
2) Every letter is small.
3) Every letter is capital.


Example 1
Input: $s = 'Perl'
Output: 1

Example 2
Input: $s = 'TPF'
Output: 1

Example 3
Input: $s = 'PyThon'
Output: 0

Example 4
Input: $s = 'raku'
Output: 1


Task 2: Decoded List
Submitted by: Mohammad S Anwar
You are given an encoded string consisting of a sequence of numeric characters: 0..9, $s.

Write a script to find the all valid different decodings in sorted order.

Encoding is simply done by mapping A,B,C,D,... to 1,2,3,4,... etc.

Example 1
Input: $s = 11
Output: AA, K

11 can be decoded as (1 1) or (11) i.e. AA or K

Example 2
Input: $s = 1115
Output: AAAE, AAO, AKE, KAE, KO

Possible decoded data are:
(1 1 1 5) => (AAAE)
(1 1 15)  => (AAO)
(1 11 5)  => (AKE)
(11 1 5)  => (KAE)
(11 15)   => (KO)

Example 3
Input: $s = 127
Output: ABG, LG

Possible decoded data are:
(1 2 7) => (ABG)
(12 7)  => (LG)
