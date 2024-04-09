from typing import List

def create_target_array(source: List[int], indices: List[int]) -> List[int]:
    target = []
    for s, i in zip(source, indices):
        target.insert(i, s)
    return target

# Test the function
assert create_target_array([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]) == [0, 4, 1, 3, 2]
assert create_target_array([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]) == [0, 1, 2, 3, 4]
assert create_target_array([1], [0]) == [1]
