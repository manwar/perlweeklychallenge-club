#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge" ""

import re
import sys


def extend_part(rat_part, part_length) -> str:
    s = rat_part[1]
    while len(s) < part_length:
        s += rat_part[2]

    return s[:part_length]


def same_rational_numbers(*rats) -> bool:
    # Convert rational numbers into three parts (whole number, part before the
    #  parentheses, and part within the parentheses)
    rat_parts = []
    for rat in rats:
        m = re.search(r"(\d+)(?:\.(\d*)(?:\((\d+)\))?)?$", rat)
        if not m:
            raise ValueError("The value {rat} is invalid!")
        rat_parts.append([m.group(1) or "0", m.group(2) or "", m.group(3) or "0"])

    # If the whole part isn't the same, return false early
    if len(set(r[0] for r in rat_parts)) != 1:
        return False

    # For the rest of the rational number, check they are all the same if
    #  expanding the recurring amount to at least twice the length of the
    #  longest number
    part_length = max(len(r[1]) + 2 * len(r[2]) for r in rat_parts)
    if len(set(extend_part(r, part_length) for r in rat_parts)) != 1:
        return False

    return True


def main():
    """Convert command line input into parameters for the function and display result"""
    result = same_rational_numbers(*sys.argv[1:])
    print("true" if result else "false")


# Call main if run from the command line
if __name__ == "__main__":
    main()
