#!/usr/bin/env python
# -*- coding: utf-8 -*-

import heapq


def last_member(ints):
    ints = [-i for i in ints]
    heapq.heapify(ints)

    while len(ints) > 1:
        x = -heapq.heappop(ints)
        y = -heapq.heappop(ints)

        if x != y:
            heapq.heappush(ints, -(x - y))

    return -ints[0] if ints else 0


print(last_member([2, 7, 4, 1, 8, 1]))
print(last_member([1]))
print(last_member([1, 1]))
