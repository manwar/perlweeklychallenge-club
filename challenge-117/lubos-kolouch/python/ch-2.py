#!/usr/bin/env python
# -*- coding: utf-8 -*-


def find_paths(n, pos=(0, 0), path=''):
    directions = {'R': (0, 1), 'L': (1, 0), 'H': (1, 1)}
    paths = []
    if pos == (n-1, n-1):
        return [path]
    for move, (dx, dy) in directions.items():
        new_pos = (pos[0]+dx, pos[1]+dy)
        if 0 <= new_pos[0] < n and pos[1] <= new_pos[1] < n:
            paths.extend(find_paths(n, new_pos, path+move))
    return paths


# For N = 1
print(find_paths(2))

# For N = 2
print(find_paths(3))
