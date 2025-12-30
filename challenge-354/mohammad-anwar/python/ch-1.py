#!/usr/bin/env python3

import sys

def min_abs_diff(ints):
    a = sorted(ints)
    m = 9**9

    for i in range(len(a) - 1):
        diff = a[i+1] - a[i]
        if diff < m:
            m = diff

    return [
        [a[i], a[i+1]]
        for i in range(len(a) - 1)
        if a[i+1] - a[i] == m
    ]

if __name__ == "__main__":
    examples = [
        {"in": [4, 2, 1, 3],      "out": [[1, 2], [2, 3], [3, 4]]},
        {"in": [10, 100, 20, 30], "out": [[10, 20], [20, 30]]},
        {"in": [-5, -2, 0, 3],    "out": [[-2, 0]]},
        {"in": [8, 1, 15, 3],     "out": [[1, 3]]},
        {"in": [12, 5, 9, 1, 15], "out": [[9, 12], [12, 15]]},
    ]

    all_pass = True
    for i, example in enumerate(examples, 1):
        result = min_abs_diff(example["in"])
        expected = example["out"]
        if result == expected:
            print(f"ok {i} -")
