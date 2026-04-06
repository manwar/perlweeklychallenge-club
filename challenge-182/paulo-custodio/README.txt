Perl Weekly Challenge 182
https://theweeklychallenge.org/blog/perl-weekly-challenge-182/

Task 1: Max Index
Submitted by: Mohammad S Anwar
You are given a list of integers.

Write a script to find the index of the first biggest number in the list.

Example
Input: @n = (5, 2, 9, 1, 7, 6)
Output: 2 (as 3rd element in the list is the biggest number)


Input: @n = (4, 2, 3, 1, 5, 0)
Output: 4 (as 5th element in the list is the biggest number)


Task 2: Common Path
Submitted by: Julien Fiegehenn
Given a list of absolute Linux file paths, determine the deepest path to the directory that contains all of them.

Example
Input:
    /a/b/c/1/x.pl
    /a/b/c/d/e/2/x.pl
    /a/b/c/d/3/x.pl
    /a/b/c/4/x.pl
    /a/b/c/d/5/x.pl

Output:
    /a/b/c
