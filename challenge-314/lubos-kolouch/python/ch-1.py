#!/usr/bin/env python3
"""Solution for Perl Weekly Challenge 314 Task 1: Equal Strings"""


def equal_strings_ops(s1, s2, s3):
    """Return the minimum number of rightmost deletions required to make the three strings equal,
    or -1 when no non-empty common prefix exists."""
    min_len = min(len(s1), len(s2), len(s3))

    i = 0
    while i < min_len:
        if s1[i] != s2[i] or s1[i] != s3[i]:
            break
        i += 1

    if i == 0:
        return -1
    return (len(s1) - i) + (len(s2) - i) + (len(s3) - i)


# Test cases from the blog
if __name__ == "__main__":
    test_cases = [
        ("abc", "abb", "ab", 2),
        ("ayz", "cyz", "xyz", -1),
        ("yza", "yzb", "yzc", 3),
    ]

    for s1, s2, s3, expected in test_cases:
        result = equal_strings_ops(s1, s2, s3)
        status = (
            "OK" if result == expected else f"FAILED: got {result}, expected {expected}"
        )
        print(f"equal_strings_ops('{s1}', '{s2}', '{s3}') = {result} [{status}]")
