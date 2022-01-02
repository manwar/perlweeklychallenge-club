#!/usr/bin/env python

import sys
import re


def main(inputs):
    first_nums = list(map(int, re.findall(r'-?\d+', inputs[0])))
    second_nums = list(map(int, re.findall(r'-?\d+', inputs[1])))

    if len(first_nums) != len(second_nums):
        raise ValueError('Arrays are of different lengths')

    dots = []
    sums = []
    for i in range(len(first_nums)):
        dots.append(f'({first_nums[i]} × {second_nums[i]})')
        sums.append(first_nums[i] * second_nums[i])

    print(' + '.join(dots) +
          ' => ' +
          ' + '.join(map(str, sums)) +
          ' => ' +
          str(sum(sums)))


if __name__ == '__main__':
    main(sys.argv[1:])
