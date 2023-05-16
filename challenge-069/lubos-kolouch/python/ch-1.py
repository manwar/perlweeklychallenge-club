#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def is_strobogrammatic(n: int) -> bool:
    """Check if a number is strobogrammatic."""
    strobo_pairs = {'0': '0', '1': '1', '6': '9', '8': '8', '9': '6'}
    str_n = str(n)
    return all(strobo_pairs.get(i) == j for i, j in zip(str_n, str_n[::-1]))


def find_strobogrammatic(A: int, B: int) -> List[int]:
    """Find all strobogrammatic numbers in a given range."""
    return [n for n in range(A, B+1) if is_strobogrammatic(n)]


# test cases to validate the solution

assert (find_strobogrammatic(50, 100) == [69, 88, 96])
