#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def numbers_with_sum_of_digits(N: int, S: int) -> List[int]:

    def helper(n: int, s: int, current: int) -> List[int]:
        if n == 0:
            return [current] if s == 0 else []

        numbers = []
        for i in range(10):
            if n == N and i == 0:  # First digit can't be 0
                continue
            if s - i >= 0:
                numbers.extend(helper(n - 1, s - i, current * 10 + i))
        return numbers

    return helper(N, S, 0)


N = 2
S = 4

print(numbers_with_sum_of_digits(N, S))  # Output: [13, 22, 31, 40]
