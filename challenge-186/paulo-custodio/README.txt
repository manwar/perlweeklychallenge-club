Perl Weekly Challenge 186
https://theweeklychallenge.org/blog/perl-weekly-challenge-186/

Task 1: Zip List
Submitted by: Mohammad S Anwar
You are given two list @a and @b of same size.

Create a subroutine sub zip(@a, @b) that merge the two list as shown in the example below.

Example
Input:  @a = qw/1 2 3/; @b = qw/a b c/;
Output: zip(@a, @b) should return qw/1 a 2 b 3 c/;
        zip(@b, @a) should return qw/a 1 b 2 c 3/;


Task 2: Unicode Makeover
Submitted by: Mohammad S Anwar
You are given a string with possible unicode characters.

Create a subroutine sub makeover($str) that replace the unicode characters with ascii equivalent. For this task, let us assume it only contains alphabets.

Example 1
Input: $str = '√ Õ“Ÿ';
Output: 'AEIOU'

Example 2
Input: $str = '‚ Ì“Ÿ';
Output: 'aEiOU'
