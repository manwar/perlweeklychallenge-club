#!/usr/bin/env python3

import re
import sys


def balance_string(input_string: str) -> str:
    # Separate letters and digits
    digits = sorted(re.findall(r"\d", input_string))
    letters = sorted(
        re.findall(r"[A-Za-z]", input_string),
        key=str.lower
    )

    # If the difference in length is more than 1, there is no solution
    if abs(len(digits) - len(letters)) > 1:
        return ""

    # If the lengths are unequal, add a blank to the shorter list
    if len(digits) < len(letters):
        digits.insert(0, "")
    elif len(letters) < len(digits):
        letters.append("")

    # Interleave the two lists, digits first
    solution = ""
    for i in range(len(digits)):
        solution += digits[i] + letters[i]

    return solution


def main():
    result = balance_string(sys.argv[1])
    print('"' + result + '"')


if __name__ == "__main__":
    main()
