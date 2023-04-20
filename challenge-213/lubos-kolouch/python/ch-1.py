#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def fun_sort(numbers: List[int]) -> List[int]:
    even = sorted([num for num in numbers if num % 2 == 0])
    odd = sorted([num for num in numbers if num % 2 == 1])
    return even + odd


if __name__ == "__main__":
    input_numbers = [1, 2, 3, 4, 5, 6]
    output_numbers = fun_sort(input_numbers)
    print(f"Input: @list = {input_numbers}")
    print(f"Output: {output_numbers}")
