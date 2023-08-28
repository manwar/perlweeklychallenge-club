#!/usr/bin/env python
# -*- coding: utf-8 -*-

def count_special_integers(n):
    count = 0

    # Iterate through 1 to n and check if each number has unique digits
    for i in range(1, n + 1):
        digits_seen = {}
        for digit in str(i):
            digits_seen[digit] = digits_seen.get(digit, 0) + 1
        # If all digits are unique, the number is special
        if all(value == 1 for value in digits_seen.values()):
            count += 1

    return count


# Test Cases
assert count_special_integers(15) == 14, 'Count of special integers up to 15'
assert count_special_integers(35) == 32, 'Count of special integers up to 35'

print("All tests passed!")
