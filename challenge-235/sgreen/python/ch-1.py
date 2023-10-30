#!/usr/bin/env python3

import sys


def main(ints):
    # Loop through each position of the list
    for i in range(len(ints)):
        # Make a new list with the integer at that position remove
        new_list = ints.copy()
        del new_list[i]

        # Check if the list is incremental
        if all(new_list[j-1] <= new_list[j] for j in range(1, len(new_list))):
            # It is, tell the user about it
            print('true')
            return

    # Oh dear. No solution is possible
    print('false')


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
