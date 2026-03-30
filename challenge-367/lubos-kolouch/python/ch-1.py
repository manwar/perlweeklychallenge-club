#!/usr/bin/env python3

"""
Challenge 367 - Task #1: Max Odd Binary
Submitted by Mohammad Sajid Anwar

You are given a binary string that has at least one '1'.

Write a script to rearrange the bits in such a way that the resulting binary
number is the maximum odd binary number and return the resulting binary string.
The resulting string can have leading zeros.
"""

import sys


def max_odd_binary(bin_str: str) -> str:
    """Return maximum odd binary number by rearranging bits."""
    if "1" not in bin_str:
        raise ValueError("Input must contain at least one '1'")
    ones = bin_str.count("1")
    zeros = len(bin_str) - ones
    # Result: (ones-1) '1's, then zeros, then one '1' at the end
    return "1" * (ones - 1) + "0" * zeros + "1"


def main():
    if len(sys.argv) != 2:
        print("Usage: python ch-1.py <binary_string>")
        sys.exit(1)
    bin_str = sys.argv[1]
    result = max_odd_binary(bin_str)
    print(result)


if __name__ == "__main__":
    main()
