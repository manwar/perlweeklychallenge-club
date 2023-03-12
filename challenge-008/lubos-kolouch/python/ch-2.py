#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def center(lines: List[str]) -> List[str]:
    # Find the maximum length of the lines
    max_length = max(len(line) for line in lines)

    # Center each line by adding spaces at the beginning
    centered_lines = []
    for line in lines:
        padding = (max_length - len(line)) // 2
        centered_line = " " * padding + line
        centered_lines.append(centered_line)

    return centered_lines


# Test cases
lines1 = ["This", "is", "a test of the", "center function"]
expected1 = ["     This", "      is", " a test of the", "center function"]
assert center(lines1) == expected1
