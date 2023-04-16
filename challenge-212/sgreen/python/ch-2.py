#!/usr/bin/env python3

import sys


def main(array):
    # Take off the last value, and sort the remaining numbers
    n = array.pop()
    array = sorted(array)
    solution = []

    while array:
        # Get the smallest number, and create a set with expected numbers
        expected = range(array[0], array[0]+n)
        not_matched = set(expected)

        # Create an new array less the first instance of each number in the set
        new_array = []
        for num in array:
            if num in not_matched:
                not_matched.remove(num)
            else:
                new_array.append(num)

        if not_matched:
            # We don't have the expected numbers
            print('-1')
            return

        # We have a solution
        solution.append('(' + ','.join([str(x) for x in expected]) + ')')
        array = new_array

    # Print the solution
    print(', '.join(solution))


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
