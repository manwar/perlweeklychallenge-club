from typing import List


def merge_items(items1: List[List[int]], items2: List[List[int]]) -> List[List[int]]:
    merged: dict[int, int] = {}
    for item_id, quantity in items1 + items2:
        merged[item_id] = merged.get(item_id, 0) + quantity
    return [[item_id, quantity] for item_id, quantity in sorted(merged.items())]


# Test cases
assert merge_items([[1, 1], [2, 1], [3, 2]], [[2, 2], [1, 3]]) == [
    [1, 4],
    [2, 3],
    [3, 2],
]
assert merge_items([[1, 2], [2, 3], [1, 3], [3, 2]], [[3, 1], [1, 3]]) == [
    [1, 8],
    [2, 3],
    [3, 3],
]
assert merge_items([[1, 1], [2, 2], [3, 3]], [[2, 3], [2, 4]]) == [
    [1, 1],
    [2, 9],
    [3, 3],
]
