from typing import List


def find_target_indices(ints: List[int], k: int) -> List[int]:
    sorted_with_indices = sorted(enumerate(ints), key=lambda x: x[1])
    return [i for i, (original_index, value) in enumerate(sorted_with_indices)
            if value == k]


# Test cases
assert find_target_indices([1, 5, 3, 2, 4, 2], 2) == [1, 2]
assert find_target_indices([1, 2, 4, 3, 5], 6) == []
assert find_target_indices([5, 3, 2, 4, 2, 1], 4) == [4]
