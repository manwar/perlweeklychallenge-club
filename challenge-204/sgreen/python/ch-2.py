#!/usr/bin/env python3

import re
import sys


def main(n):
    # Remove the last two numbers
    c = int(n.pop())
    r = int(n.pop())

    # Check there there is a viable solution
    if len(n) != c * r:
        print('0')
        return

    # Print the result
    for i in range(0, len(n), c):
        print('[ ' + ' '.join(n[i:i+c]) + ' ]')


if __name__ == '__main__':
    # Extract all the integers
    inputs = ' '.join(sys.argv[1:])
    nums = re.findall(r'-?\d+', inputs)
    main(nums)
