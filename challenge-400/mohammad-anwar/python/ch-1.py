#!/usr/bin/env python3

import re

def max_jump(num):
    nums = [i for i in range(1, num + 1) if not re.search(r"(\d).*\1", str(i))]
    max_diff = 0

    for i in range(1, len(nums)):
        diff = nums[i] - nums[i - 1]
        if diff > max_diff:
            max_diff = diff

    return max_diff

examples = [
    { "in": 20,    "out": 2    },
    { "in": 110,   "out": 4    },
    { "in": 500,   "out": 11   },
    { "in": 2026,  "out": 105 },
    { "in": 10000, "out": 105 },
]

for ex in examples:
    assert max_jump(ex["in"]) == ex["out"], f"Test failed for input {ex['in']}"

print("All tests passed!")
