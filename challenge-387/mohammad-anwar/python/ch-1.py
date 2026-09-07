#!/usr/bin/env python3

import re

examples = [
    {"in": "111000", "out": 0},
    {"in": "00011",  "out": 4},
    {"in": "01011",  "out": 3},
    {"in": "010101", "out": 3},
    {"in": "00001",  "out": 4},
]

def min_steps(s: str) -> int:
    steps = 0
    while "01" in s:
        s = re.sub(r"01", "10", s)
        steps += 1
    return steps

for ex in examples:
    result = min_steps(ex["in"])
    assert result == ex["out"], f"Failed for {ex['in']}: expected {ex['out']}, got {result}"

print("All tests passed!")
