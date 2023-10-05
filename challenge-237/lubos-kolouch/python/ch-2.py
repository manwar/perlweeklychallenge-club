#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Debugging the maximise_greatness function
def maximise_greatness(nums):
    sorted_nums = sorted(nums)
    greatness = 0

    # Debugging: Print the sorted list
#    print(f"Sorted list: {sorted_nums}")

    for i in range(len(nums)):
        for j in range(len(sorted_nums)):
            if nums[i] < sorted_nums[j]:
                greatness += 1
                del sorted_nums[j]
                break

        # Debugging: Print the remaining sorted list after each iteration
#        print(f"Remaining sorted list: {sorted_nums}")

    return greatness


# Test the function
print(maximise_greatness([1, 3, 5, 2, 1, 3, 1]))  # Should return 4
print(maximise_greatness([1, 2, 3, 4]))  # Should return 3
