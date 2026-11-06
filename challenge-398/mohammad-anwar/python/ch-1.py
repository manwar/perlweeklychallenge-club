#!/usr/bin/env python3

import math

examples = [
    {"in": [18, 5, 7, 11],          "out": 18},
    {"in": [6, 12, 18, 24, 30, 40], "out": 18},
    {"in": [3, 9, 15, 21, 27],      "out": 0 },
    {"in": [6, 12, 14, 20],         "out": 9 },
    {"in": [6, 6, 6, 12, 12],       "out": 8 },
]

def divisible_average(arr):
    filtered = [x for x in arr if x % 6 == 0]
    if not filtered:
        return 0

    total_sum = sum(filtered)
    return math.floor(total_sum / len(filtered) + 0.5)

for ex in examples:
    assert divisible_average(ex["in"]) == ex["out"]

print("All tests passed!")
