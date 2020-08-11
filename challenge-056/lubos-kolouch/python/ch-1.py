#!/usr/bin/env python
"""
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-056/
    Task 1

    You are given an array @N of positive integers (sorted) and another non negative integer k.
    Write a script to find if there exists 2 indices i and j such that A[i] - A[j] = k and i != j.
    It should print the pairs of indices, if any such pairs exist.
"""


def get_valid_pairs(k: int, arr: list):
    """ get all valid pairs"""

    answer = ''

    for i in range(0, len(arr)-1):
        j = i + 1

        while (arr[j] - arr[i] < k) and (j < len(arr) - 1):
            j += 1

        if arr[j] - arr[i] == k:
            answer += f"({j},{i})"

    return answer


# TESTS
assert get_valid_pairs(2, (2, 7, 9)) == "(2,1)"
assert get_valid_pairs(2, (2, 4, 6)) == "(1,0)(2,1)"
assert get_valid_pairs(2, (2, 8, 9)) == ''
