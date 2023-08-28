#!/usr/bin/env python
# -*- coding: utf-8 -*-


def find_triplet(arr):
    arr.sort(reverse=True)
    for i in range(len(arr) - 2):
        if arr[i] < arr[i + 1] + arr[i + 2]:
            return (arr[i], arr[i + 1], arr[i + 2])
    return ()


print(find_triplet([1, 2, 3, 2]))  # Output: (3, 2, 2)
print(find_triplet([1, 3, 2]))  # Output: ()
print(find_triplet([1, 1, 2, 3]))  # Output: ()
print(find_triplet([2, 4, 3]))  # Output: (4, 3, 2)
