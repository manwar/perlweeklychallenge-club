#!/usr/bin/env python
# -*- coding: utf-8 -*-

def find_ranges(array):
    ranges = []
    start, end = None, None

    for num in array:
        if start is None:
            start = end = num
        elif num == end + 1:
            end = num
        else:
            if end > start:
                ranges.append([start, end])
            start = end = num

    if start is not None and end > start:
        ranges.append([start, end])

    return ranges


# Test cases
assert find_ranges([1, 3, 4, 5, 7]) == [[3, 5]], "Example 1"
assert find_ranges([1, 2, 3, 6, 7, 9]) == [[1, 3], [6, 7]], "Example 2"
assert find_ranges([0, 1, 2, 4, 5, 6, 8, 9]) == [
    [0, 2], [4, 6], [8, 9]], "Example 3"

print("All tests passed!")
