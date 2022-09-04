#!/usr/bin/env python3

import sys


def main(phrase):
    # Go through each character
    for i in range(len(phrase)-1):

        # If the letter in that position does not occur  later, print the index
        if phrase[i] not in phrase[i+1:]:
            print(i)
            return

    # Oh dear. Nothing unique!
    print('No unique characters!')


if __name__ == '__main__':
    main(sys.argv[1])
