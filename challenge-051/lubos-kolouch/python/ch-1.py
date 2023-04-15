#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List, Tuple


def find_unique_triplets(target: int, lst: List[int]) -> List[Tuple[int, int, int]]:
    lst.sort()

    triplets = []
    length = len(lst)

    for i in range(length - 2):
        left = i + 1
        right = length - 1

        while left < right:
            s = lst[i] + lst[left] + lst[right]

            if s == target:
                triplets.append((lst[i], lst[left], lst[right]))
                left += 1
                right -= 1
            elif s < target:
                left += 1
            else:
                right -= 1

    return triplets

if __name__ == "__main__":
    L = [-25, -10, -7, -3, 2, 4, 8, 10]
    target = 0

    triplets = find_unique_triplets(target, L)
    for triplet in triplets:
        print(triplet)
