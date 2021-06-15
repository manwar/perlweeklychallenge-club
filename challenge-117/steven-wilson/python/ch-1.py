#!/usr/bin/env python
import sys


if __name__ == "__main__":
    filename = sys.argv[1]
    file = open(filename)
    lines = file.readlines()
    line_numbers = [int(line.split(',')[0]) for line in lines]
    line_numbers.sort()
    number = 1
    for line_number in line_numbers:
        if number != line_number:
            break
        else:
            number += 1
    print("The missing row number is %d" % number)