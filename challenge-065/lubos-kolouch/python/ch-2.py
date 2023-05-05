#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def is_palindrome(s: str) -> bool:
    return s == s[::-1]


def palindrome_partitions(s: str, start: int, current_partition: List[str],
                          result: List[List[str]]) -> None:
    if start == len(s):
        result.append(current_partition[:])
        return

    for end in range(start + 1, len(s) + 1):
        substr = s[start:end]
        if is_palindrome(substr):
            current_partition.append(substr)
            palindrome_partitions(s, end, current_partition, result)
            current_partition.pop()


S = 'aabaab'
result = []

palindrome_partitions(S, 0, [], result)

if result:
    print(f"There are {len(result)} possible solutions.")
    for index, partition in enumerate(result, start=1):
        print(f"{index}) {', '.join(partition)}")
else:
    print("-1")
