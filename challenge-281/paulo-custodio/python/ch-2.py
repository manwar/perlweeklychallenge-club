#!/usr/bin/env python3

import sys

def find_path_size(start, end):
    min_path = None
    paths = [([start], {start: 1})]

    while paths:
        top = paths.pop(0)
        path = top[0]
        seen = top[1]

        # check if we found a solution
        if path[-1] == end:  # found one solution
            if min_path is None or min_path > len(path):
                min_path = len(path)  # found shorter solution

        # prune the tree
        if min_path is not None and len(path) > min_path:
            continue

        # find 8 next positions and push them to paths
        dest = knight_jump(path[-1])
        for d in dest:
            if d not in seen:
                paths.append([path + [d], {**seen, d: 1}])

    return min_path - 1  # remove start position

def row_col(coord):
    if not (coord[0] in 'abcdefgh' and coord[1] in '12345678'):
        raise ValueError("Invalid coordinate")
    row = 8 - int(coord[1])
    col = ord(coord[0]) - ord('a')
    return row, col

def coord(row, col):
    if row < 0 or row > 7 or col < 0 or col > 7:
        return None
    return chr(col + ord('a')) + str(8 - row)

def knight_jump(start):
    row, col = row_col(start)
    dest = []

    for r_offset, c_offset in [(-2, -1), (-2, 1), (2, -1), (2, 1), (-1, -2), (1, -2), (-1, 2), (1, 2)]:
        end = coord(row + r_offset, col + c_offset)
        if end is not None:
            dest.append(end)

    return dest

if len(sys.argv) != 3:
    sys.exit("Usage: {} start end".format(sys.argv[0]))

start, end = sys.argv[1], sys.argv[2]
for pos in (start, end):
    if not (pos[0] in 'abcdefgh' and pos[1] in '12345678'):
        sys.exit("Usage: {} start end".format(sys.argv[0]))

print(find_path_size(start, end))
