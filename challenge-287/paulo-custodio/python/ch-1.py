#!/usr/bin/env python3

# Challenge 287
#
# Task 1: Strong Password
# Submitted by: Mohammad Sajid Anwar
#
# You are given a string, $str.
#
# Write a program to return the minimum number of steps required to make the
# given string very strong password. If it is already strong then return 0.
#
# Criteria:
#
# - It must have at least 6 characters.
# - It must contains at least one lowercase letter, at least one upper case
#   letter and at least one digit.
# - It shouldn't contain 3 repeating characters in a row.
#
# Following can be considered as one step:
#
# - Insert one character
# - Delete one character
# - Replace one character with another
#
# Example 1
#
# Input: $str = "a"
# Output: 5
#
# Example 2
#
# Input: $str = "aB2"
# Output: 3
#
# Example 3
#
# Input: $str = "PaaSW0rd"
# Output: 0
#
# Example 4
#
# Input: $str = "Paaasw0rd"
# Output: 1
#
# Example 5
#
# Input: $str = "aaaaa"
# Output: 2

import re
import sys

def is_strong(password):
    if len(password) < 6:
        return False
    elif not re.search(r'[a-z]', password):
        return False
    elif not re.search(r'[A-Z]', password):
        return False
    elif not re.search(r'[0-9]', password):
        return False
    elif re.search(r'(.)\1\1+', password):
        return False
    else:
        return True

def charset(a, b):
    return "".join([chr(x) for x in range(ord(a), ord(b)+1)])

def next_char(password):
    avail_chars = ""
    if not re.search(r'[a-z]', password):
        avail_chars += charset('a', 'z')
    if not re.search(r'[A-Z]', password):
        avail_chars += charset('A', 'Z')
    if not re.search(r'[0-9]', password):
        avail_chars += charset('0', '9')
    avail_chars += charset('a', 'z')
    avail_chars += charset('A', 'Z')
    avail_chars += charset('0', '9')

    for ch in password:
        avail_chars, _ = re.subn(ch, '', avail_chars)

    return avail_chars[0]

def steps_to_strong(password):
    steps = 0
    while not is_strong(password):
        if re.search(r'(.)\1\1+', password):
            password = re.sub(r'(.)\1\1', r'\1\1'+next_char(password)+'\1', password)
        else:
            password += next_char(password)
        steps += 1
    return steps

print(steps_to_strong(sys.argv[1]))
