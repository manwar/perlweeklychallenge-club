#!/usr/bin/env python3
"""Reverse Pairs - Perl Weekly Challenge 243, Task 1."""

from __future__ import annotations

import unittest


def _merge_sort(nums: list[int], left: int, right: int) -> int:
    """Sort nums[left..right] in place and return the reverse pair count."""
    if left >= right:
        return 0

    mid = (left + right) // 2
    count = _merge_sort(nums, left, mid) + _merge_sort(nums, mid + 1, right)

    i = left
    j = mid + 1
    while i <= mid:
        while j <= right and nums[i] > 2 * nums[j]:
            j += 1
        count += j - (mid + 1)
        i += 1

    sorted_nums: list[int] = []
    i = left
    j = mid + 1
    while i <= mid and j <= right:
        if nums[i] <= nums[j]:
            sorted_nums.append(nums[i])
            i += 1
        else:
            sorted_nums.append(nums[j])
            j += 1
    sorted_nums.extend(nums[i : mid + 1])
    sorted_nums.extend(nums[j : right + 1])
    nums[left : right + 1] = sorted_nums

    return count


def count_reverse_pairs(nums: list[int]) -> int:
    """Return the number of reverse pairs (i, j) with i < j and nums[i] > 2 * nums[j]."""
    arr = list(nums)
    if len(arr) < 2:
        return 0
    return _merge_sort(arr, 0, len(arr) - 1)


class TestReversePairs(unittest.TestCase):
    """Unit tests for the count_reverse_pairs function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[list[int], int]] = [
            ([1, 3, 2, 3, 1], 2),
            ([2, 4, 3, 5, 1], 3),
        ]
        for nums, expected in cases:
            with self.subTest(nums=nums):
                self.assertEqual(count_reverse_pairs(nums), expected)


if __name__ == "__main__":
    unittest.main()
