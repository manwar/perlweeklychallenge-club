Challenge 325
https://theweeklychallenge.org/blog/perl-weekly-challenge-325/

Task 1: Consecutive One
Submitted by: Mohammad Sajid Anwar
You are given a binary array containing only 0 or/and 1.

Write a script to find out the maximum consecutive 1 in the given array.


Example 1
Input: @binary = (0, 1, 1, 0, 1, 1, 1)
Output: 3

Example 2
Input: @binary = (0, 0, 0, 0)
Output: 0

Example 3
Input: @binary = (1, 0, 1, 0, 1, 1)
Output: 2

Task 2: Final Price
Submitted by: Mohammad Sajid Anwar
You are given an array of item prices.

Write a script to find out the final price of each items in the given array.

There is a special discount scheme going on. If there’s an item with a lower or equal price later in the list, you get a discount equal to that later price (the first one you find in order).


Example 1
Input: @prices = (8, 4, 6, 2, 3)
Output: (4, 2, 4, 2, 3)

Item 0:
The item price is 8.
The first time that has price <= current item price is 4.
Final price = 8 - 4 => 4

Item 1:
The item price is 4.
The first time that has price <= current item price is 2.
Final price = 4 - 2 => 2

Item 2:
The item price is 6.
The first time that has price <= current item price is 2.
Final price = 6 - 2 => 4

Item 3:
The item price is 2.
No item has price <= current item price, no discount.
Final price = 2

Item 4:
The item price is 3.
Since it is the last item, so no discount.
Final price = 3

Example 2
Input: @prices = (1, 2, 3, 4, 5)
Output: (1, 2, 3, 4, 5)

Example 3
Input: @prices = (7, 1, 1, 5)
Output: (6, 0, 1, 5)

Item 0:
The item price is 7.
The first time that has price <= current item price is 1.
Final price = 7 - 1 => 6

Item 1:
The item price is 1.
The first time that has price <= current item price is 1.
Final price = 1 - 1 => 0

Item 2:
The item price is 1.
No item has price <= current item price, so no discount.
Final price = 1

Item 3:
The item price is 5.
Since it is the last item, so no discount.
Final price = 5
