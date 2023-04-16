#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def generate_numbers(numbers: List[int], x: int, y: int, current: str) -> List[int]:
    if x == 0:
        return [int(current)] if int(current) < y else []
    result = []
    for num in numbers:
        result.extend(generate_numbers(numbers, x - 1, y, current + str(num)))
    return result

if __name__ == "__main__":
    L = [0, 1, 2, 5]
    X = 2
    Y = 21

    output = generate_numbers(L, X, Y, "")
    print(", ".join(map(str, output)))
