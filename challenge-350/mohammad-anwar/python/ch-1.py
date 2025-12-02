#!/usr/bin/env python3

import re
from collections import Counter

def good_substring(s: str) -> int:
    return sum(1 for i in range(len(s) - 2)
               if len(set(s[i:i+3])) == 3)

examples = [
    ("abcaefg", 5),
    ("xyzzabc", 3),
    ("aababc",  1),
    ("qwerty",  4),
    ("zzzaaa",  0),
]

for s, expected in examples:
    result = good_substring(s)
    assert result == expected, f"Failed for '{s}'"

print("All tests passed!")
