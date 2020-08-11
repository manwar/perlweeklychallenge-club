#!/usr/bin/env python

import sys
import heapq

# 1. n_queens_3d finds the solution using beam search
# 2. the higher the beam_width, the better is the solution. 
# 3. with beam_width=1, it's very fast but the solution may not be optimal maximising the number of queens.
# 4. with beam_width=-1, it searches the entire search space. Ensures best solution but slow as hell for high n
# 5. I think one can find the best solution with beam_width 2-3 for n-values less than 8


def n_queens_3d (n = 2, beam_width = 2):
    solutions = []
    place_queen ([(i, j, k) for i in range(n) for j in range(n) for k in range(n)], 
                 [], 
                 solutions, 
                 beam_width=beam_width)
    best = max(solutions, key=len)
    print(f"queens: {len(best)}")
    return indices_to_array( best, n)

def place_queen (indices, queens, solutions, beam_width=2):
    if not indices: 
        solutions.append(queens)
        return
    if beam_width == -1:
        best = ((index, [i for i in indices if is_available(index, i)]) for index in indices)
    else:
        best = heapq.nlargest(beam_width, 
                              ((index, [i for i in indices if is_available(index, i)]) for index in indices), 
                              key=lambda pair: len(pair[1]))
    for pos, available in best:
        place_queen (available, [*queens, pos], solutions, beam_width=beam_width)

def is_available(ref, pos):
    diff = {abs(i - j) for i, j in zip (ref, pos)}
    return not ( len(diff) < 2 or (len(diff) == 2 and 0 in diff))

def indices_to_array (indices, n):
    array = [[[0 for _ in range(n)] for _ in range(n)] for _ in range(n)]
    for i, j, k in indices:
        array[i][j][k] = 1
    return array

n = int(sys.argv[1]) if len(sys.argv) > 1 else 2
beam_width = int(sys.argv[2]) if len(sys.argv) > 2 else 2

print(n_queens_3d (n, beam_width))

