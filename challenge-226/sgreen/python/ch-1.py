#!/usr/bin/env python3

import sys


def main(word, ints):
    # Create a mapping of position to character
    mapping = {ints[i]: word[i] for i in range(len(ints))}

    # Work through the dict in numerical order
    solution = ''
    for i in sorted(mapping):
        solution += mapping[i]

    # Print the resulting word
    print(solution)


if __name__ == '__main__':
    word = sys.argv[1]
    # Convert the remaining input into integers
    ints = [int(i) for i in sys.argv[2:]]
    main(word, ints)
