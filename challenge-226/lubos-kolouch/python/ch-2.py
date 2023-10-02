#!/usr/bin/env python
# -*- coding: utf-8 -*-


def min_zero_operations(ints):
    positives = [x for x in ints if x > 0]

    if not positives:
        return 0

    smallest = min(positives)

    operations = 0

    while smallest > 0:
        for i in range(len(ints)):
            if ints[i] > 0:
                ints[i] -= smallest
        operations += 1

        positives = [x for x in ints if x > 0]
        smallest = min(positives) if positives else 0

    return operations


print(min_zero_operations([0, 0, 0]))  # 0
print(min_zero_operations([1, 5, 0, 3, 5]))  # 3
print(min_zero_operations([2, 1, 4, 0, 3]))  # 4
