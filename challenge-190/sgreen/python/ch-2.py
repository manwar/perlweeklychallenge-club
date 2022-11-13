#!/usr/bin/env python3

import string
import sys


def main(s):
    '''Main function'''

    # Loop through the alphabet
    letter_map = {}
    for k, v in enumerate(string.ascii_uppercase):
        letter_map[str(k+1)] = v

    # Record completed solutions
    solutions = []

    # Start with the input string
    stack = [(s, '')]

    while stack:
        (numbers, letters) = stack.pop(0)

        if numbers == '':
            # If we have no numbers for this stack, it is a solution
            solutions.append(letters)
        else:
            # Consider either the first single or two numbers
            for l in (1, 2):
                if len(numbers) >= l and numbers[:l] in letter_map:
                    # If we have a mapping, add to the stack list with the
                    #  remaining numbers, and appending this letter to the
                    #  letters
                    stack.append(
                        (numbers[l:], letters + letter_map[numbers[:l]]))

    # Print the solutions
    if solutions:
        print(*sorted(solutions), sep=', ')
    else:
        print('No solution possible')


if __name__ == '__main__':
    main(sys.argv[1])
