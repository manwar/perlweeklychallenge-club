Challenge 303
https://theweeklychallenge.org/blog/perl-weekly-challenge-303/

Task 1: 3-digits Even
Submitted by: Mohammad Sajid Anwar
You are given a list (3 or more) of positive integers, @ints.

Write a script to return all even 3-digits integers that can be formed using the integers in the given list.

Example 1
Input: @ints = (2, 1, 3, 0)
Output: (102, 120, 130, 132, 210, 230, 302, 310, 312, 320)
Example 2
Input: @ints = (2, 2, 8, 8, 2)
Output: (222, 228, 282, 288, 822, 828, 882)

Task 2: Delete and Earn
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to return the maximum number of points you can earn by applying the following operation some number of times.

Pick any ints[i] and delete it to earn ints[i] points.
Afterwards, you must delete every element equal to ints[i] - 1
and every element equal to ints[i] + 1.
Example 1
Input: @ints = (3, 4, 2)
Output: 6

Delete 4 to earn 4 points, consequently, 3 is also deleted.
Finally delete 2 to earn 2 points.
Example 2
Input: @ints = (2, 2, 3, 3, 3, 4)
Output: 9

Delete a 3 to earn 3 points. All 2's and 4's are also deleted too.
Delete a 3 again to earn 3 points.
Delete a 3 once more to earn 3 points.
