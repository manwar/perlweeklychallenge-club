#!/usr/bin/env python3

import re
import sys


def max_score(input_string: str) -> int:
    # Check that the input contains only ones and zeros
    if not re.match(r'^[01]+$', input_string):
        raise ValueError("Input must contain only '0' and '1' characters")

    current_max = 0

    # Split the string at each position and count the 0s on the left and 1s
    #  on the right
    for i in range(1, len(input_string)):
        left = input_string[:i].count('0')
        right = input_string[i:].count('1')

        # If the score is higher than the current max, update it
        if left + right > current_max:
            current_max = left + right

    return current_max


def main():
    result = max_score(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
