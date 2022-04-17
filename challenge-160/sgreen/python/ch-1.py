#!/usr/bin/env python

import sys


def main(n):
    # Numwbers as words
    words = ['zero', 'one', 'two', 'three', 'four',
            'five', 'six', 'seven', 'eigth', 'nine']
    if n < 0 or n > 9:
        raise ValueError('The input must be an integer between 0 and 9')

    phrases = []

    while n != 4:
        l = len(words[n])
        phrases.append(f'{words[n]} is {words[l]}')

        # Check the next phrase
        n = l

    phrases.append('four is magic.')

    phrases[0] = phrases[0].capitalize()
    print(*phrases, sep=', ')


if __name__ == '__main__':
    main(int(sys.argv[1]))
