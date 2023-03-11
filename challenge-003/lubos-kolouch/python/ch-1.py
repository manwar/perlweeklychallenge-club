#!/usr/bin/env python
# -*- coding: utf-8 -*-

def is_smooth(n):
    while n % 2 == 0:
        n //= 2
    while n % 3 == 0:
        n //= 3
    while n % 5 == 0:
        n //= 5
    return n == 1

def generate_smooth_numbers(n):
    smooth_numbers = [1]
    candidate = 1
    while len(smooth_numbers) < n:
        candidate += 1
        if is_smooth(candidate):
            smooth_numbers.append(candidate)
    return smooth_numbers

n = int(input("Enter the number of 5-smooth numbers to generate: "))
smooth_numbers = generate_smooth_numbers(n)

print(f"First {n} 5-smooth numbers:")
print(", ".join(map(str, smooth_numbers)))

import unittest


class TestSmoothNumbers(unittest.TestCase):
    def test_generate_smooth_numbers(self):
        expected = [1, 2, 3, 4, 5, 6, 8, 9, 10, 12]
        self.assertEqual(generate_smooth_numbers(10), expected)

if __name__ == '__main__':
    unittest.main()
