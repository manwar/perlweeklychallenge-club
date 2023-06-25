#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math


def is_power_of_two(n):
    return (n & (n - 1)) == 0


def is_two_friendly(m, n):
    return is_power_of_two(math.gcd(m, n))


print(1 if is_two_friendly(8, 24) else 0)
print(1 if is_two_friendly(26, 39) else 0)
print(1 if is_two_friendly(4, 10) else 0)
