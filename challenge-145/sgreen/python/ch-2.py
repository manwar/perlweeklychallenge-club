#!/usr/bin/env python

import sys


def main(word):
    strings = []

    # Make the starting point from each character
    for i in range(len(word)):

        # And the end point
        for j in range(i, len(word)):

            # This is string we will examine
            s = word[i:j + 1]

            # If we don't already know about it, and it's palindromic, add
            #  it to the string array
            if s not in strings and s == s[::-1]:
                strings.append(s)

    print(*strings, sep=' ')


if __name__ == '__main__':
    main(sys.argv[1])
