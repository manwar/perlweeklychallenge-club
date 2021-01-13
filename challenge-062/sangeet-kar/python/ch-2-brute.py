#!/usr/bin/env python

import sys

def n_queens_3d (n = 2):
    solutions = []
    place_queen ([(i, j, k) for i in range(n) for j in range(n) for k in range(n)], [], solutions)
    return indices_to_array(max(solutions, key=len), n);

def place_queen (indices, queens, solutions):
    if not indices: solutions.append(queens)
    for pos in indices:
        place_queen ([index for index in indices if is_available(pos, index)], [*queens, pos], solutions)

def is_available(ref, pos):
    diff = {abs(i - j) for i, j in zip (ref, pos)}
    return not ( len(diff) < 2 or (len(diff) == 2 and 0 in diff))

def indices_to_array (indices, n):
    array = [[[0 for _ in range(n)] for _ in range(n)] for _ in range(n)]
    for i, j, k in indices:
        array[i][j][k] = 1
    return array

n = int(sys.argv[1]) if len(sys.argv) > 1 else 2
print(n_queens_3d (n))

