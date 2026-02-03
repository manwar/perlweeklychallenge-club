Challenge 357
https://theweeklychallenge.org/blog/perl-weekly-challenge-357/

Task 1: Kaprekar Constant
Submitted by: Mohammad Sajid Anwar
Write a function that takes a 4-digit integer and returns how many iterations are required to reach Kaprekar’s constant (6174). For more information about Kaprekar's Constant please follow the wikipedia page.

Example 1
Input: $int = 3524
Output: 3

Iteration 1: 5432 - 2345 = 3087
Iteration 2: 8730 - 0378 = 8352
Iteration 3: 8532 - 2358 = 6174

Example 2
Input: $int = 6174
Output: 0

Example 3
Input: $int = 9998
Output: 5

Iteration 1: 9998 - 8999 = 0999
Iteration 2: 9990 - 0999 = 8991
Iteration 3: 9981 - 1899 = 8082
Iteration 4: 8820 - 0288 = 8532
Iteration 5: 8532 - 2358 = 6174

Example 4
Input: $int = 1001
Output: 4

Iteration 1: 1100 - 0011 = 1089
Iteration 2: 9810 - 0189 = 9621
Iteration 3: 9621 - 1269 = 8352
Iteration 4: 8532 - 2358 = 6174

Example 5
Input: $int = 9000
Output: 4

Iteration 1: 9000 - 0009 = 8991
Iteration 2: 9981 - 1899 = 8082
Iteration 3: 8820 - 0288 = 8532
Iteration 4: 8532 - 2358 = 6174

Example 6
Input: $int = 1111
Output: -1

The sequence does not converge on 6174, so return -1.

Task 2: Unique Fraction Generator
Submitted by: Yary
Given a positive integer N, generate all unique fractions you can create using integers from 1 to N and follow the rules below:

- Use numbers 1 through N only (no zero)
- Create fractions like numerator/denominator
- List them in ascending order (from smallest to largest)
- If two fractions have the same value (like 1/2 and 2/4),
  only show the one with the smallest numerator
Example 1
Input: $int = 3
Output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1
Example 2
Input: $int = 4
Output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1

Example 3
Input: $int = 1
Output: 1/1

Example 4
Input: $int = 6
Output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
        4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
        5/2, 3/1, 4/1, 5/1, 6/1

Example 5
Input: $int = 5
Output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
        5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1
