#!/usr/bin/env python3

def trionic(arr):
    n = len(arr)
    if n < 4:
        return 'false'

    i = 0
    while i < n - 1 and arr[i] < arr[i + 1]:
        i += 1
    p = i
    if p == 0:
        return 'false'

    while i < n - 1 and arr[i] > arr[i + 1]:
        i += 1
    q = i

    if q == p or q >= n - 1:
        return 'false'

    while i < n - 1 and arr[i] < arr[i + 1]:
        i += 1

    return 'true' if i == n - 1 else 'false'

examples = [
    { "in": [1, 3, 5, 4, 2, 6, 8],    "out": 'true'  },
    { "in": [1, 4, 4, 2, 1, 3, 5],    "out": 'false' },
    { "in": [2, 10, 3, 1, 9],         "out": 'true'  },
    { "in": [1, 2, 3, 4, 3, 2, 1],    "out": 'false' },
    { "in": [1, 3, 6, 4, 2, 7, 8, 4], "out": 'false' },
]

for ex in examples:
    assert trionic(ex["in"]) == ex["out"]

print("All tests passed!")
