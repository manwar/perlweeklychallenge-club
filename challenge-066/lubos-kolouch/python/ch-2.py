#!/usr/bin/env python
# -*- coding: utf-8 -*-

from math import sqrt, log


def find_expressions(N: int):
    solutions = []

    for m in range(2, int(sqrt(N)) + 1):
        for n in range(2, int(log(N) / log(m)) + 1):
            if m**n == N:
                solutions.append(f"{m}^{n}")

    return solutions or 0


N = 64
result = find_expressions(N)
if isinstance(result, list):
    print(' or '.join(result))
else:
    print("0")
