#!/usr/bin/env python

from typing import List


def count_reverse_pairs(nums: list[int]) -> int:
    def merge_sort(left: int, right: int) -> int:
        if left >= right:
            return 0

        mid = (left + right) // 2
        count = merge_sort(left, mid) + merge_sort(mid + 1, right)

        # Count reverse pairs
        i, j = left, mid + 1
        while i <= mid:
            while j <= right and nums[i] > 2 * nums[j]:
                j += 1
            count += j - (mid + 1)
            i += 1

        # Merge step
        sorted_nums = []
        i, j = left, mid + 1
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

    return merge_sort(0, len(nums) - 1)


# Testing with example inputs
print(count_reverse_pairs([1, 3, 2, 3, 1]))  # Output: 2
print(count_reverse_pairs([2, 4, 3, 5, 1]))  # Output: 3
