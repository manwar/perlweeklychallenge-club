#!/usr/bin/python3

'''

Week 135:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-135

Task #1: Middle 3-digits

    You are given an integer.

    Write a script find out the middle 3-digits of the given integer, if possible otherwise throw sensible error.

'''

import sys, math, re, getopt

def main(argv):
    try:
        opts, arg = getopt.getopt(argv, "hn:", ["number="])
    except getopt.GetoptError:
        print('ch-1.py -n <number>')
        sys.exit(2)

    for opt, arg in opts:
        if opt == '-h':
            print('ch-1.py -n <number>')
            sys.exit()
        elif opt in ("-n", "--number"):
            number = arg

    valid = re.compile('^\-?\d+$')
    if valid.match(number):
        num  = abs(int(number))
        size = int_size(num)

        if size == 1:
            print('ERROR: Too short')
            sys.exit()

        if size % 2 == 0:
            print('ERROR: Even number of digits.')
            sys.exit()

        i = int(size / 2) - 1
        s = str(num)

        print(s[i:i+3])

    else:
        print('Invalid number')

def int_size(n):
    return 1 + math.floor(math.log10(n))

if __name__ == "__main__":
    main(sys.argv[1:])
