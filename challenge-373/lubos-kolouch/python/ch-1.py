#!/usr/bin/env python3
"""Solution for Perl Weekly Challenge 373 Task 1: Equal List"""


def equal_list(arr1, arr2):
    """Return True if two arrays of strings represent the same concatenated string."""
    return "".join(arr1) == "".join(arr2)


# Test cases
if __name__ == "__main__":
    test_cases = [
        (["a", "bc"], ["ab", "c"], True),
        (["a", "b", "c"], ["a", "bc"], True),
        (["a", "bc"], ["a", "c", "b"], False),
        (["ab", "c", ""], ["", "a", "bc"], True),
        (["p", "e", "r", "l"], ["perl"], True),
    ]

    for i, (arr1, arr2, expected) in enumerate(test_cases, 1):
        result = equal_list(arr1, arr2)
        status = "OK" if result == expected else "FAILED"
        print(f"Test {i}: {status}")
