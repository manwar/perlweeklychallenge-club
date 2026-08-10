#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge" ""

import re
import sys


def nearest_color(hex_string: str) -> str:
    """Convert a hex value to the nearest web safe value"""
    mapping = {230: "FF", 179: "CC", 128: "99", 77: "66", 26: "33"}
    value = int(hex_string, base=16)
    for key, result in mapping.items():
        if value >= key:
            return result

    return "00"


def nearest_rgb(input_string: str) -> str:
    """Convert a RGB color to the nearest 'web safe' color"""

    # Check the string is valid
    if not re.search(r"^#[0-9A-F]{6}$", input_string):
        raise ValueError(f"Invalid input")

    # Generate the nearest color by each byte
    return (
        "#"
        + nearest_color(input_string[1:3])
        + nearest_color(input_string[3:5])
        + nearest_color(input_string[5:7])
    )


def main():
    """Convert command line input into parameters for the function and display result"""
    result = nearest_rgb(sys.argv[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
