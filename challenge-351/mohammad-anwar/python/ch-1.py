#!/usr/bin/env python3

import statistics

def special_average(nums):
    if not nums:
        return 0

    min_val = min(nums)
    max_val = max(nums)

    filtered = [x for x in nums if x != min_val and x != max_val]
    if not filtered:
        return 0

    return sum(filtered) / len(filtered)

examples = [
    {"in": [8000, 5000, 6000, 2000, 3000, 7000], "out": 5250  },
    {"in": [100_000, 80_000, 110_000, 90_000],   "out": 95_000},
    {"in": [2500, 2500, 2500, 2500],             "out": 0     },
    {"in": [2000],                               "out": 0     },
    {"in": [1000, 2000, 3000, 4000, 5000, 6000], "out": 3500  },
]

for i, example in enumerate(examples, 1):
    result   = special_average(example["in"])
    expected = example["out"]
    if result == expected:
        print(f"ok {i}")
    else:
        print(f"not ok {i}")
