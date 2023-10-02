from math import sqrt


def is_stealthy(n):
    factors = []
    for i in range(1, int(sqrt(n)) + 1):
        if n % i == 0:
            factors.append((i, n // i))

    for i in range(len(factors)):
        for j in range(i, len(factors)):
            a, b = factors[i]
            c, d = factors[j]
            if a + b == c + d + 1:
                return True

    return False


print(is_stealthy(36))  # Output: True
print(is_stealthy(12))  # Output: True
print(is_stealthy(6))  # Output: False
#!/usr/bin/env python
# -*- coding: utf-8 -*-
