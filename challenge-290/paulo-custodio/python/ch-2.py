#!/usr/bin/env python3

# Challenge 290
#
# Task 2: Luhn's Algorithm
# Submitted by: Andrezgz
#
# You are given a string $str containing digits (and possibly other characters
# which can be ignored). The last digit is the payload; consider it separately.
# Counting from the right, double the value of the first, third, etc. of the
# remaining digits.
#
# For each value now greater than 9, sum its digits.
#
# The correct check digit is that which, added to the sum of all values, would
# bring the total mod 10 to zero.
#
# Return true if and only if the payload is equal to the correct check digit.
#
# It was originally posted on reddit.
# Example 1
#
# Input: "17893729974"
# Output: true
#
# Payload is 4.
#
# Digits from the right:
#
# 7 * 2 = 14, sum = 5
# 9 = 9
# 9 * 2 = 18, sum = 9
# 2 = 2
# 7 * 2 = 14, sum = 5
# 3 = 3
# 9 * 2 = 18, sum = 9
# 8 = 8
# 7 * 2 = 14, sum = 5
# 1 = 1
#
# Sum of all values = 56, so 4 must be added to bring the total mod 10 to zero.
# The payload is indeed 4.
#
# Example 2
#
# Input: "4137 8947 1175 5904"
# Output: true
#
# Example 3
#
# Input: "4137 8974 1175 5904"
# Output: false

import sys

def is_luhn(s):
    s = ''.join(filter(str.isdigit, s))
    payload = int(s[-1])
    sum_ = 0
    factor = 2
    for i in range(len(s) - 2, -1, -1):
        digit = factor * int(s[i])
        if digit > 9:
            sum_ += sum(int(d) for d in str(digit))
        else:
            sum_ += digit
        factor = 3 - factor
    return (sum_ + payload) % 10 == 0

print("true" if is_luhn(" ".join(sys.argv[1:])) else "false")
