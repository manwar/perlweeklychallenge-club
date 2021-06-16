#!/usr/bin/env python
import sys


if __name__ == "__main__":
    filename = sys.argv[1]
    file = open(filename)
    lines = file.readlines()
    line_numbers = [int(line.split(',')[0]) for line in lines]
    # Math method
    sum_of_line_numbers = sum(line_numbers)
    sum_of_range = sum(range(1, (len(line_numbers) + 2)))
    number = sum_of_range - sum_of_line_numbers

    # Iterative method
#     line_numbers.sort()
#     number = 1
#     for line_number in line_numbers:
#         if number != line_number:
#             break
#         else:
#             number += 1

    print("The missing row number is %d" % number)