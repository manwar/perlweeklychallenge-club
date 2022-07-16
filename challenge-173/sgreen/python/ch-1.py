#!/usr/bin/env python

import sys


def main(n):
    # The first character is 0 .. len(n)-2
    for i in range(len(n)-1):
        # Calculate the difference between that number and the next
        diff = abs(int(n[i]) - int(n[i+1]))
        if diff != 1:
            # This is not a esthetic number
            print('0')
            return

    # This is a esthetic number
    print('1')


if __name__ == '__main__':
    main(sys.argv[1])
