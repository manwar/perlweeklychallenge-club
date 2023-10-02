#!/usr/bin/env python
# -*- coding: utf-8 -*-

def count_divisors_with_last_digit(m, n):
    count = 0
    for i in range(1, m + 1):
        if m % i == 0 and i % 10 == n:
            count += 1
    return count


print(count_divisors_with_last_digit(24, 2))
print(count_divisors_with_last_digit(30, 5))
