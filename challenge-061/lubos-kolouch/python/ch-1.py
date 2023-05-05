#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def max_product_sublist(nums: List[int]) -> int:
    max_product = nums[0]
    min_product = nums[0]
    result = nums[0]

    for i in range(1, len(nums)):
        if nums[i] < 0:
            max_product, min_product = min_product, max_product

        max_product = max(nums[i], nums[i] * max_product)
        min_product = min(nums[i], nums[i] * min_product)

        result = max(result, max_product)

    return result


input_nums = [2, 5, -1, 3]
max_product = max_product_sublist(input_nums)
print(f"Maximum product: {max_product}")  # Output: Maximum product: 10
