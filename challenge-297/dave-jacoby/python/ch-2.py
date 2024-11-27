#!/usr/bin/python3

import copy
import re


def main():
    examples = [
        [2, 1, 4, 3],
        [2, 4, 1, 3],
        [1, 2, 3, 4, 5],
        [9, 8, 7, 6, 2, 3, 4, 5, 1],
    ]
    for e in examples:
        input = ", ".join(str(i) for i in e)
        output = semi_ordered_permute(e)
        print(f"    Input:  ints = [{input}]")
        print(f"    Output: {output}")
        print("")


def semi_ordered_permute(array):
    max = len(array)
    min = 1
    steps = 0
    while min != array[0]:
        i = first_index_that_equals(array, min)
        (array[i], array[i - 1]) = (array[i - 1], array[i])
        steps += 1
    while max != array[-1]:
        i = first_index_that_equals(array, max)
        (array[i], array[i + 1]) = (array[i + 1], array[i])
        steps += 1
    return steps


def first_index_that_equals(array, value):
    indexes = [*range(len(array))]
    for i in [*range(len(array))]:
        if value == array[i]:
            return i


if __name__ == "__main__":
    main()
