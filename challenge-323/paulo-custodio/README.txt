Challenge 323
https://theweeklychallenge.org/blog/perl-weekly-challenge-323/

Task 1: Increment Decrement
Submitted by: Mohammad Sajid Anwar
You are given a list of operations.

Write a script to return the final value after performing the given operations in order. The initial value is always 0.

Possible Operations:
++x or x++: increment by 1
--x or x--: decrement by 1

Example 1
Input: @operations = ("--x", "x++", "x++")
Output: 1

Operation "--x" =>  0 - 1 => -1
Operation "x++" => -1 + 1 =>  0
Operation "x++" =>  0 + 1 =>  1

Example 2
Input: @operations = ("x++", "++x", "x++")
Output: 3

Example 3
Input: @operations = ("x++", "++x", "--x", "x--")
Output: 0

Operation "x++" => 0 + 1 => 1
Operation "++x" => 1 + 1 => 2
Operation "--x" => 2 - 1 => 1
Operation "x--" => 1 - 1 => 0

Task 2: Tax Amount
Submitted by: Mohammad Sajid Anwar
You are given an income amount and tax brackets.

Write a script to calculate the total tax amount.


Example 1
Input: $income = 10, @tax = ([3, 50], [7, 10], [12,25])
Output: 2.65

1st tax bracket upto  3, tax is 50%.
2nd tax bracket upto  7, tax is 10%.
3rd tax bracket upto 12, tax is 25%.

Total Tax => (3 * 50/100) + (4 * 10/100) + (3 * 25/100)
          => 1.50 + 0.40 + 0.75
          => 2.65

Example 2
Input: $income = 2, @tax = ([1, 0], [4, 25], [5,50])
Output: 0.25

Total Tax => (1 * 0/100) + (1 * 25/100)
          => 0 + 0.25
          => 0.25

Example 3
Input: $income = 0, @tax = ([2, 50])
Output: 0
