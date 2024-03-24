from typing import List


def element_digit_sum(ints: List[int]) -> int:
    element_sum = sum(ints)
    digit_sum = sum(int(c) for n in ints for c in str(n))
    return abs(element_sum - digit_sum)


# Test cases
assert element_digit_sum([1, 2, 3, 45]) == 36, "Test Case 1"
assert element_digit_sum([1, 12, 3]) == 9, "Test Case 2"
assert element_digit_sum([1, 2, 3, 4]) == 0, "Test Case 3"
assert element_digit_sum([236, 416, 336, 350]) == 1296, "Test Case 4"
