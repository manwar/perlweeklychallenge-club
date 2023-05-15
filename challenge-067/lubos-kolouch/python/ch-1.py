#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def combinations(m: int, n: int) -> List[List[int]]:
    result = []

    def rec_comb(start: int, depth: int, comb: List[int]) -> None:
        if depth == 0:
            result.append(comb)
            return
        for i in range(start, m + 1):
            rec_comb(i + 1, depth - 1, comb + [i])

    rec_comb(1, n, [])
    return result


m, n = 5, 2
combinations_list = combinations(m, n)
print("[", ", ".join(str(comb) for comb in combinations_list), "]")
