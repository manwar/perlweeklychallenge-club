Perl Weekly Challenge 287
https://theweeklychallenge.org/blog/perl-weekly-challenge-287/

Task 1: Strong Password
Submitted by: Mohammad Sajid Anwar
You are given a string, $str.

Write a program to return the minimum number of steps required to make the given string very strong password. If it is already strong then return 0.

Criteria:

- It must have at least 6 characters.
- It must contains at least one lowercase letter, at least one upper case letter and at least one digit.
- It shouldn't contain 3 repeating characters in a row.
Following can be considered as one step:

- Insert one character
- Delete one character
- Replace one character with another
Example 1
Input: $str = "a"
Output: 5
Example 2
Input: $str = "aB2"
Output: 3
Example 3
Input: $str = "PaaSW0rd"
Output: 0
Example 4
Input: $str = "Paaasw0rd"
Output: 1
Example 5
Input: $str = "aaaaa"
Output: 2

Task 2: Valid Number
Submitted by: Mohammad Sajid Anwar
You are given a string, $str.

Write a script to find if it is a valid number.

Conditions for a valid number:

- An integer number followed by an optional exponent.
- A decimal number followed by an optional exponent.
- An integer number is defined with an optional sign '-' or '+' followed by digits.
Decimal Number:

A decimal number is defined with an optional sign '-' or '+' followed by one of the following definitions:
- Digits followed by a dot '.'.
- Digits followed by a dot '.' followed by digits.
- A dot '.' followed by digits.
Exponent:

An exponent is defined with an exponent notation 'e' or 'E' followed by an integer number.
Example 1
Input: $str = "1"
Output: true
Example 2
Input: $str = "a"
Output: false
Example 3
Input: $str = "."
Output: false
Example 4
Input: $str = "1.2e4.2"
Output: false
Example 5
Input: $str = "-1."
Output: true
Example 6
Input: $str = "+1E-8"
Output: true
Example 7
Input: $str = ".44"
Output: true
