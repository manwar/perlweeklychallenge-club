Task 1: Day of the Year
Submitted by: Mohammad Sajid Anwar
You are given a date in the format YYYY-MM-DD.

Write a script to find day number of the year that the given date represent.


Example 1
Input: $date = '2025-02-02'
Output: 33

The 2nd Feb, 2025 is the 33rd day of the year.

Example 2
Input: $date = '2025-04-10'
Output: 100

Example 3
Input: $date = '2025-09-07'
Output: 250

Task 2: Decompressed List
Submitted by: Mohammad Sajid Anwar
You are given an array of positive integers having even elements.

Write a script to to return the decompress list. To decompress, pick adjacent pair (i, j) and replace it with j, i times.


Example 1
Input: @ints = (1, 3, 2, 4)
Output: (3, 4, 4)

Pair 1: (1, 3) => 3 one time  => (3)
Pair 2: (2, 4) => 4 two times => (4, 4)

Example 2
Input: @ints = (1, 1, 2, 2)
Output: (1, 2, 2)

Pair 1: (1, 1) => 1 one time  => (1)
Pair 2: (2, 2) => 2 two times => (2, 2)

Example 3
Input: @ints = (3, 1, 3, 2)
Output: (1, 1, 1, 2, 2, 2)

Pair 1: (3, 1) => 1 three times => (1, 1, 1)
Pair 2: (3, 2) => 2 three times => (2, 2, 2)
