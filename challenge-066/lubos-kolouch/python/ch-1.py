#!/usr/bin/env python
# -*- coding: utf-8 -*-


def divide(M: int, N: int) -> int:
    if N == 0:
        raise ValueError("Division by zero is not allowed.")

    sign = -1 if (M < 0) ^ (N < 0) else 1
    M, N = abs(M), abs(N)

    result = 0
    while M >= N:
        M -= N
        result += 1

    return sign * result


M = -5
N = -2
output = divide(M, N)
print(output)
