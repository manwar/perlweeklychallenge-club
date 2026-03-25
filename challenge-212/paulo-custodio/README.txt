Perl Weekly Challenge 212
https://theweeklychallenge.org/blog/perl-weekly-challenge-212/

Task 1: Jumping Letters
Submitted by: Mohammad S Anwar
You are given a word having alphabetic characters only, and a list of positive integers of the same length

Write a script to print the new word generated after jumping forward each letter in the given word by the integer in the list. The given list would have exactly the number as the total alphabets in the given word.


Example 1
Input: $word = 'Perl' and @jump = (2,22,19,9)
Output: Raku

'P' jumps 2 place forward and becomes 'R'.
'e' jumps 22 place forward and becomes 'a'. (jump is cyclic i.e. after 'z' you go back to 'a')
'r' jumps 19 place forward and becomes 'k'.
'l' jumps 9 place forward and becomes 'u'.

Example 2
Input: $word = 'Raku' and @jump = (24,4,7,17)
Output: 'Perl'


Task 2: Rearrange Groups
Submitted by: Mohammad S Anwar
You are given a list of integers and group size greater than zero.

Write a script to split the list into equal groups of the given size where integers are in sequential order. If it can’t be done then print -1.


Example 1:
Input: @list = (1,2,3,5,1,2,7,6,3) and $size = 3
Output: (1,2,3), (1,2,3), (5,6,7)

Example 2:
Input: @list = (1,2,3) and $size = 2
Output: -1

Example 3:
Input: @list = (1,2,4,3,5,3) and $size = 3
Output: (1,2,3), (3,4,5)

Example 4:
Input: @list = (1,5,2,6,4,7) and $size = 3
Output: -1
