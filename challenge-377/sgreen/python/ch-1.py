#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge"""

import sys


def reverse_existence(input_string: str) -> bool:
    reversed_string = input_string[::-1]
    for start_pos in range(len(input_string)-1):
        if reversed_string[start_pos:start_pos+2] in input_string:
            return True

    return False

def main():
    """Convert command line input into parameters for the function and display result"""
    result = reverse_existence(sys.argv[1])
    print("true" if result else "false")


# Call main if run from the command line
if __name__ == "__main__":
    main()
