#!/usr/bin/env python
# -*- coding: utf-8 -*-

from itertools import permutations
from collections import deque


def knight_moves(start, end):
    # Calculate the knight distance between start and end using a breadth-first search
    moves = [(2, 1), (1, 2), (-1, 2), (-2, 1),
             (-2, -1), (-1, -2), (1, -2), (2, -1)]
    visited = set()
    queue = deque([(start, 0)])
    while queue:
        pos, dist = queue.popleft()
        if pos == end:
            return dist
        if pos in visited:
            continue
        visited.add(pos)
        for move in moves:
            next_pos = (pos[0] + move[0], pos[1] + move[1])
            if 0 <= next_pos[0] < 8 and 0 <= next_pos[1] < 8:
                queue.append((next_pos, dist + 1))


def shortest_path(treasures):
    # Find the permutation of treasures with the shortest total distance
    start = (0, 0)
    shortest_dist = float('inf')
    shortest_perm = None
    for perm in permutations(treasures):
        total_dist = sum(knight_moves(perm[i], perm[i+1])
                         for i in range(len(perm) - 1))
        total_dist += knight_moves(start,
                                   perm[0]) + knight_moves(perm[-1], start)
        if total_dist < shortest_dist:
            shortest_dist = total_dist
            shortest_perm = perm
    return shortest_perm


# The treasures' positions
treasures = [(1, 1), (1, 0), (2, 0), (2, 1), (3, 1), (5, 3)]

print(shortest_path(treasures))
