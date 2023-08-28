#!/usr/bin/env python3

import sys


def main(ints):
    solution = [digit for i in ints for digit in i]
    print('(' + ', '.join(solution) + ')')


if __name__ == '__main__':
    main(sys.argv[1:])
