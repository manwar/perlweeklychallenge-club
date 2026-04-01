Perl Weekly Challenge 184
https://theweeklychallenge.org/blog/perl-weekly-challenge-184/

Task 1: Sequence Number
Submitted by: Mohammad S Anwar
You are given list of strings in the format aa9999 i.e. first 2 characters can be anything 'a-z' followed by 4 digits '0-9'.

Write a script to replace the first two characters with sequence starting with '00', '01', '02' etc.

Example 1
Input: @list = ( 'ab1234', 'cd5678', 'ef1342')
Output: ('001234', '015678', '021342')

Example 2
Input: @list = ( 'pq1122', 'rs3334')
Output: ('001122', '013334')


Task 2: Split Array
Submitted by: Mohammad S Anwar
You are given list of strings containing 0-9 and a-z separated by space only.

Write a script to split the data into two arrays, one for integers and one for alphabets only.

Example 1
Input: @list = ( 'a 1 2 b 0', '3 c 4 d')
Output: [[1,2,0], [3,4]] and [['a','b'], ['c','d']]

Example 2
Input: @list = ( '1 2', 'p q r', 's 3', '4 5 t')
Output: [[1,2], [3], [4,5]] and [['p','q','r'], ['s'], ['t']]
