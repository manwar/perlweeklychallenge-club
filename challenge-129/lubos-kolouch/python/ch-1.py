#!/usr/bin/env python
# -*- coding: utf-8 -*-

tree = {1: [2, 3], 3: [4], 4: [5, 6]}


def distance(node, root, dist):
    if root == node:
        return dist
    if root in tree:
        for child in tree[root]:
            d = distance(node, child, dist + 1)
            if d is not None:
                return d


print(distance(6, 1, 0))
print(distance(5, 1, 0))
print(distance(2, 1, 0))
print(distance(4, 1, 0))
