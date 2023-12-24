#!/usr/bin/env python3

import sys


def main(word, char):
    # Obtain the positions of the character in the string
    positions = [i for i, s in enumerate(word) if s == char]

    if len(positions) == 0:
        # Throw an error if we don't find the character in the string
        raise ValueError(f"'{char}' does not appear in string")

    # Record the position of the first occurrence of the character, and the next
    current_pos = positions.pop(0)
    next_pos = positions.pop(0) if len(positions) > 0 else current_pos

    solution = []
    for i in range(len(word)):
        if abs(i - next_pos) < abs(i-current_pos):
            # We are closer to the next occurrence of the character
            current_pos = next_pos
            next_pos = positions.pop(0) if len(positions) > 0 else current_pos

        # Record the closest occurrence for this position
        solution.append(abs(i-current_pos))

    # Print the solution
    print('(' + ','.join(map(str, solution)) + ')')


if __name__ == '__main__':
    main(*sys.argv[1:])
