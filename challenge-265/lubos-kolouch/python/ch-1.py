from collections import Counter
from typing import List, Optional


def find_integer_appearing_33_percent_or_more(ints: List[int]) -> Optional[int]:

    if not ints:
        return None

    count = Counter(ints)
    n = len(ints)
    threshold = n / 3

    # Finding all numbers that appear at least 33% of the time
    valid_numbers = [num for num, cnt in count.items() if cnt >= threshold]

    # Return the smallest integer that meets the criteria, or None if no such integer exists
    return min(valid_numbers) if valid_numbers else None


# Test cases
assert find_integer_appearing_33_percent_or_more([1, 2, 3, 3, 3, 3, 4, 2]) == 3
assert find_integer_appearing_33_percent_or_more([1, 1]) == 1
assert find_integer_appearing_33_percent_or_more([1, 2, 3]) == 1
assert find_integer_appearing_33_percent_or_more([]) is None
