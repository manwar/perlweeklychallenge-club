Perl Weekly Challenge 367
https://theweeklychallenge.org/blog/perl-weekly-challenge-367/

Task 1: Max Odd Binary
Submitted by: Mohammad Sajid Anwar
You are given a binary string that has at least one ‘1’.

Write a script to rearrange the bits in such a way that the resulting binary number is the maximum odd binary number and return the resulting binary string. The resulting string can have leading zeros.

Example 1
Input: $str = "1011"
Output: "1101"

"1101" is max odd binary (13).

Example 2
Input: $str = "100"
Output: "001"

"001" is max odd binary (1).

Example 3
Input: $str = "111000"
Output: "110001"

Example 4
Input: $str = "0101"
Output: "1001"

Example 5
Input: $str = "1111"
Output: "1111"

Task 2: Conflict Events
Submitted by: Mohammad Sajid Anwar
You are given two events start and end time.

Write a script to find out if there is a conflict between the two events. A conflict happens when two events have some non-empty intersection.

Example 1
Input: @event1 = ("10:00", "12:00")
       @event2 = ("11:00", "13:00")
Output: true

Both events overlap from "11:00" to "12:00".

Example 2
Input: @event1 = ("09:00", "10:30")
       @event2 = ("10:30", "12:00")
Output: false

Event1 ends exactly at 10:30 when Event2 starts.
Since the problem defines intersection as non-empty, exact boundaries touching is not a conflict.

Example 3
Input: @event1 = ("14:00", "15:30")
       @event2 = ("14:30", "16:00")
Output: true

Both events overlap from 14:30 to 15:30.

Example 4
Input: @event1 = ("08:00", "09:00")
       @event2 = ("09:01", "10:00")
Output: false

There is a 1-minute gap from "09:00" to "09:01".

Example 5
Input: @event1 = ("23:30", "00:30")
       @event2 = ("00:00", "01:00")
Output: true

They overlap from "00:00" to "00:30".
