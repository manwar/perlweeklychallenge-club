Perl Weekly Challenge 229
https://theweeklychallenge.org/blog/perl-weekly-challenge-229/

Task 1: Lexicographic Order
Submitted by: Mohammad S Anwar
You are given an array of strings.

Write a script to delete element which is not lexicographically sorted (forwards or backwards) and return the count of deletions.

Example 1
Input: @str = ("abc", "bce", "cae")
Output: 1

In the given array "cae" is the only element which is not lexicographically sorted.

Example 2
Input: @str = ("yxz", "cba", "mon")
Output: 2

In the given array "yxz" and "mon" are not lexicographically sorted.


Task 2: Two out of Three
Submitted by: Mohammad S Anwar
You are given three array of integers.

Write a script to return all the elements that are present in at least 2 out of 3 given arrays.

Example 1
Input: @array1 = (1, 1, 2, 4)
       @array2 = (2, 4)
       @array3 = (4)
Ouput: (2, 4)

Example 2
Input: @array1 = (4, 1)
       @array2 = (2, 4)
       @array3 = (1, 2)
Ouput: (1, 2, 4)
