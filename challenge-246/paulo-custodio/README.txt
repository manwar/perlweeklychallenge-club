Perl Weekly Challenge 246
https://theweeklychallenge.org/blog/perl-weekly-challenge-246/

Task 1: 6 out of 49
Submitted by: Andreas Voegele
6 out of 49 is a German lottery.

Write a script that outputs six unique random integers from the range 1 to 49.

Output
3
10
11
22
38
49


Task 2: Linear Recurrence of Second Order
Submitted by: Jorg Sommrey
You are given an array @a of five integers.

Write a script to decide whether the given integers form a linear recurrence of second order with integer factors.

A linear recurrence of second order has the form

a[n] = p * a[n-2] + q * a[n-1] with n > 1

where p and q must be integers.


Example 1
Input: @a = (1, 1, 2, 3, 5)
Output: true

@a is the initial part of the Fibonacci sequence a[n] = a[n-2] + a[n-1]
with a[0] = 1 and a[1] = 1.

Example 2
Input: @a = (4, 2, 4, 5, 7)
Output: false

a[1] and a[2] are even. Any linear combination of two even numbers with integer factors is even, too.
Because a[3] is odd, the given numbers cannot form a linear recurrence of second order with integer factors.

Example 3
Input: @a = (4, 1, 2, -3, 8)
Output: true

a[n] = a[n-2] - 2 * a[n-1]
