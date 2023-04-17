#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def count_different_bits(a: int, b: int) -> int:
    count = 0
    while a > 0 or b > 0:
        count += (a % 2) ^ (b % 2)
        a >>= 1
        b >>= 1
    return count

def sum_different_bits(numbers: List[int]) -> int:
    total = 0
    for i in range(len(numbers)):
        for j in range(i+1, len(numbers)):
            total += count_different_bits(numbers[i], numbers[j])
    return total

if __name__ == "__main__":
    input_list = [2, 3, 4]
    result = sum_different_bits(input_list)
    print(result)
