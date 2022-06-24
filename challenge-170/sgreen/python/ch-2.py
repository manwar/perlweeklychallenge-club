#!/usr/bin/env python

import sys
import yaml


def check_array(a):
    ''' Check that all rows in the array are the same length'''
    for i in range(1, len(a)):
        if (len(a[0]) != len(a[i])):
            raise ValueError('mismatched array width')

    return a


def main(file_name):
    # Read the supplied file in YAML format
    with open(file_name, 'r') as file:
        arrays = yaml.safe_load(file)

    if len(arrays) != 2:
        raise ValueError('Expecting two arrays')

    array1 = check_array(arrays[0])
    array2 = check_array(arrays[1])

    solution = []
    for row in array1:
        for second_row in array2:
            solution.append(list( str(c1 * c2) for c1 in row for c2 in second_row))

    # Format each row uniformly.
    max_length = max(max(len(col) for col in row) for row in solution)
    fmt = '[' + (' {:>' + str(max_length) + 's}') * len(solution[0]) + ' ]'

    for row in solution:
        print(fmt.format(*row))


if __name__ == '__main__':
    main(sys.argv[1])
