Challenge 347
https://theweeklychallenge.org/blog/perl-weekly-challenge-347/

Task 1: Format Date
Submitted by: Mohammad Sajid Anwar
You are given a date in the form: 10th Nov 2025.

Write a script to format the given date in the form: 2025-11-10 using the set below.

@DAYS   = ("1st", "2nd", "3rd", ....., "30th", "31st")
@MONTHS = ("Jan", "Feb", "Mar", ....., "Nov",  "Dec")
@YEARS  = (1900..2100)

Example 1
Input: $str = "1st Jan 2025"
Output: "2025-01-01"

Example 2
Input: $str = "22nd Feb 2025"
Output: "2025-02-22"

Example 3
Input: $str = "15th Apr 2025"
Output: "2025-04-15"

Example 4
Input: $str = "23rd Oct 2025"
Output: "2025-10-23"

Example 5
Input: $str = "31st Dec 2025"
Output: "2025-12-31"

Task 2: Format Phone Number
Submitted by: Mohammad Sajid Anwar
You are given a phone number as a string containing digits, space and dash only.

Write a script to format the given phone number using the below rules:

1. Removing all spaces and dashes
2. Grouping digits into blocks of length 3 from left to right
3. Handling the final digits (4 or fewer) specially:
   - 2 digits: one block of length 2
   - 3 digits: one block of length 3
   - 4 digits: two blocks of length 2
4. Joining all blocks with dashes

Example 1
Input: $phone = "1-23-45-6"
Output: "123-456"

Example 2
Input: $phone = "1234"
Output: "12-34"

Example 3
Input: $phone = "12 345-6789"
Output: "123-456-789"

Example 4
Input: $phone = "123 4567"
Output: "123-45-67"

Example 5
Input: $phone = "123 456-78"
Output: "123-456-78"
