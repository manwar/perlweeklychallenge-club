#!/usr/bin/env python3

import sys


def print_row(line, numbers):
    row = []

    for n in numbers:
        if type(line) == str:
            # We want to show a solid line
            if line in n:
                row.append('-------')
            else:
                row.append('       ')
        else:
            # We have a left side and right side
            left = '|' if line[0] in n else ' '
            right = '|' if line[1] in n else ' '
            row.append(f'{left}     {right}')

    print(*row, sep='  ')


def main(n):
    # Turn the numbers into a list of strings to show
    truth = 'abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg'.split(
        ' ')
    numbers = [truth[int(i)] for i in n]

    # Define the lines we want to show
    lines = [
        'a',
        ['f', 'b'],
        ['f', 'b'],
        'g',
        ['e', 'c'],
        ['e', 'c'],
        'd'
    ]

    for line in lines:
        print_row(line, numbers)


if __name__ == '__main__':
    main(sys.argv[1])
