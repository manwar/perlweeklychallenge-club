#!/usr/bin/env python3

import sys
import string


def main(s):
    # The alphabet
    alphabet = string.ascii_lowercase

    # Store the best result found
    solution = None
    occurrences = 0

    for i in range(25):
        # Get the two consecutive letters and the number of occurrences
        letters = alphabet[i:i+2]
        count = s.count(letters)

        # If it is greater than the current count, store it
        if count > occurrences:
            occurrences = count
            solution = letters

    print(solution or "No consecutive letters found!")


if __name__ == '__main__':
    main(sys.argv[1])
