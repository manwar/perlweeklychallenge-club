#! /usr/bin/python3
from collections import Counter

def equal_pairs(*ints):
    seen = Counter(ints)
    pairs = []
    for c in seen:
        if seen[c] % 2 == 1:
            return []
        else:
            pairs += map(lambda _i: [c, c], range(seen[c] // 2))
    return pairs

assert equal_pairs(3, 2, 3, 2, 2, 2) == [[3, 3], [2, 2], [2, 2]], 'Example 1'
assert equal_pairs(1, 2, 3, 4) == [], 'Example 2'
assert equal_pairs(-1, -1, -2, -2) == [[-1, -1], [-2, -2]], 'Negative numbers'
assert equal_pairs(1, 1, 1, 1, 2, 2, 2, 2) == [
    [1, 1], [1, 1], [2, 2], [2, 2]], \
    'More than once'
assert equal_pairs(1, 1, 1, 1, 2, 2, 2, 2, 1) == [], 'More than once odd';
