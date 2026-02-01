#!/usr/bin/env python3
from functools import reduce

def get_value(s):
    return len(s) if not s.isdigit() else int(s)

def test_case(name, strings, expected):
    got = max(get_value(s) for s in strings)
    status = "PASS" if got == expected else "FAIL"
    print(f"{name}: {status} (got {got}, expected {expected})")
    return got == expected

tests = [
    {"name": "Example 1", "strings": ["123", "45", "6"], "expected": 123},
    {"name": "Example 2", "strings": ["abc", "de", "fghi"], "expected": 4},
    {"name": "Example 3", "strings": ["0012", "99", "a1b2c"], "expected": 99},
    {"name": "Example 4", "strings": ["x", "10", "xyz", "007"], "expected": 10},
    {"name": "Example 5", "strings": ["hello123", "2026", "perl"], "expected": 2026},
]

print("Running tests:")
all_pass = True
for test in tests:
    all_pass = test_case(test["name"], test["strings"], test["expected"]) and all_pass
print("\nAll tests passed!") if all_pass else None
