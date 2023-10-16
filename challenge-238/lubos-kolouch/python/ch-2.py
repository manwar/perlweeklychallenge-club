from typing import List, Tuple


def persistence_sort(nums: list[int]) -> list[int]:
    def steps_to_single_digit(n: int) -> int:
        steps = 0
        while n >= 10:
            product = 1
            for digit in str(n):
                product *= int(digit)
            n = product
            steps += 1
        return steps

    return sorted(nums, key=lambda x: (steps_to_single_digit(x), x))


# Tests
print(persistence_sort([15, 99, 1, 34]))  # Output should be [1, 15, 34, 99]
print(persistence_sort([50, 25, 33, 22]))  # Output should be [22, 33, 50, 25]
