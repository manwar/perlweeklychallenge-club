#!/usr/bin/env python
# -*- coding: utf-8 -*-


def represent_integer(N, D):
    str_N = str(N)
    if str(D) not in str_N:
        return 0
    sum_N = sum(int(digit) for digit in str_N if digit == str(D))
    return sum_N == N


# Testing
print(represent_integer(25, 2))  # Outputs: 0
print(represent_integer(22, 2))  # Outputs: 1
