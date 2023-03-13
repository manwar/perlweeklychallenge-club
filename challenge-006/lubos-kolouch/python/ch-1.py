#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
This script takes a list of numbers from command line and prints them in the compact form.

Example:
    Input: 1,2,3,4,9,10,14,15,16
    Output: 1-4,9,10,14-16
"""

import sys


def CompactList(numbers):
    """This function takes a list of numbers as input and returns the list in compact form.

    Args:
        numbers (list): A list of numbers

    Returns:
        str: The list in compact form

    Examples:
        >>> CompactList([1,2,3,4,9,10,14,15,16])
        '1-4,9,10,14-16'
    """
    compact_list = []
    start = numbers[0]
    end = numbers[0]
    for i in range(1, len(numbers)):
        if numbers[i] - numbers[i - 1] == 1:
            end = numbers[i]
        else:
            if start == end:
                compact_list.append(str(start))
            else:
                compact_list.append(str(start) + "-" + str(end))
            start = numbers[i]
            end = numbers[i]
    if start == end:
        compact_list.append(str(start))
    else:
        compact_list.append(str(start) + "-" + str(end))
    return ",".join(compact_list)


if __name__ == "__main__":
    numbers = [int(i) for i in sys.argv[1].split(",")]
    print(CompactList(numbers))
