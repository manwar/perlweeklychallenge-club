#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def find_peaks(arr: List[int]) -> List[int]:
    n = len(arr)
    # Initialize peaks list with the first element if it's bigger than the second
    peaks = [arr[0]] if arr[0] > arr[1] else []

    # Iterate over the array checking for peaks
    for i in range(1, n-1):
        if arr[i] > arr[i-1] and arr[i] > arr[i+1]:
            peaks.append(arr[i])

    # Add the last element if it's bigger than the penultimate
    if arr[-1] > arr[-2]:
        peaks.append(arr[-1])

    return peaks


# Tests
print(find_peaks([18, 45, 38, 25, 10, 7, 21, 6, 28, 48]))  # [48, 45, 21]
print(find_peaks([47, 11, 32, 8, 1, 9, 39, 14, 36, 23]))  # [47, 32, 39, 36]
