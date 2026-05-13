#!/usr/bin/env python3

import unittest

def equal_list(arr1, arr2):
    return "true" if "".join(arr1) == "".join(arr2) else "false"

examples = [
    {
        "in":  [["a", "bc"], ["ab", "c"]],
        "out": "true"
    },
    {
        "in":  [["a", "b", "c"], ["a", "bc"]],
        "out": "true"
    },
    {
        "in":  [["a", "bc"], ["a", "c", "b"]],
        "out": "false"
    },
    {
        "in":  [["ab", "c", ""], ["", "a", "bc"]],
        "out": "true"
    },
    {
        "in":  [["p", "e", "r", "l"], ["perl"]],
        "out": "true"
    },
]

for ex in examples:
    result = equal_list(ex["in"][0], ex["in"][1])
    status = "ok" if result == ex["out"] else "not ok"
    print(f"{status}")
