#!/usr/bin/env python3

import re

def max_str_val(str_list):
    max_val = 0
    for s in str_list:
        if re.fullmatch(r'\d+', s):
            val = int(s)
        else:
            val = len(s)
        if val > max_val:
            max_val = val
    return max_val

# Test cases
examples = [
    {"in": ["123", "45", "6"],           "out": 123},
    {"in": ["abc", "de", "fghi"],        "out": 4},
    {"in": ["0012", "99", "a1b2c"],      "out": 99},
    {"in": ["x", "10", "xyz", "007"],    "out": 10},
    {"in": ["hello123", "2026", "perl"], "out": 2026},
]

for example in examples:
    result = max_str_val(example["in"])
    expected = example["out"]
    if result == expected:
        print(f"PASS: {example['in']} -> {result}")
    else:
        print(f"FAIL: {example['in']} -> {result}, expected {expected}")
