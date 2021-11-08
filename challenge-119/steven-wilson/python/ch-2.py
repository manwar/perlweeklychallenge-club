#!/usr/bin/env python

# TASK #2 > Sequence without 1-on-1
# 1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, ...

import re


def nth_1on1_element(nth_element):
    number = 1
    current_element = 1
    while nth_element != current_element:
        number += 1
        if (re.search(r"^[1-3]+$", str(number)) is not None) and (
            re.search(r"11", str(number)) is None
        ):
            current_element += 1
    return number


if __name__ == "__main__":
    inputs = [5, 10, 60]
    for i in inputs:
        print(nth_1on1_element(i))
