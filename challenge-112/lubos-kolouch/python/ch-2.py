#!/usr/bin/env python
# -*- coding: utf-8 -*-


def climb_stairs(n):
    if n <= 2:
        return n
    ways = [0, 1, 2]
    for i in range(3, n + 1):
        ways.append(ways[i - 1] + ways[i - 2])
    return ways[n]


# Testing
print(climb_stairs(5))  # Outputs: 8
