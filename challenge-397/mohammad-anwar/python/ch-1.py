#!/usr/bin/env python3

examples = [
    {"in": [1, 2, 4, 5, 6], "out": 7},
    {"in": [-5, -2, -1, 3], "out": 1},
    {"in": [1, 2, 3],       "out": 4},
    {"in": [2, 3, 7, 8],    "out": 6},
    {"in": [1, 1, 1, 10],   "out": 4},
]

def smallest_greater_absent(arr):
    seen = {x: True for x in arr}
    avg  = sum(arr) / len(arr)
    n    = int(avg) + 1
    if n < 1:
        n = 1
    while n in seen:
        n += 1
    return n

for ex in examples:
    assert smallest_greater_absent(ex["in"]) == ex["out"], f"Failed for {ex['in']}"

print("All tests passed successfully!")
