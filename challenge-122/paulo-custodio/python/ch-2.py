#!/usr/bin/env python3

# TASK #2 > Basketball Points
# Submitted by: Mohammad S Anwar
# You are given a score $S.
#
# You can win basketball points e.g. 1 point, 2 points and 3 points.
#
# Write a script to find out the different ways you can score $S.
#
# Example
# Input: $S = 4
# Output: 1 1 1 1
#         1 1 2
#         1 2 1
#         1 3
#         2 1 1
#         2 2
#         3 1
#
# Input: $S = 5
# Output: 1 1 1 1 1
#         1 1 1 2
#         1 1 2 1
#         1 1 3
#         1 2 1 1
#         1 2 2
#         1 3 1
#         2 1 1 1
#         2 1 2
#         2 2 1
#         2 3
#         3 1 1
#         3 2

import sys

def show_scores(N):
    def scores(N, points):
        s = sum(points)
        if s > N:
            pass
        elif s == N:
            print(" ".join([str(x) for x in points]))
        else:
            scores(N, [*points, 1])
            scores(N, [*points, 2])
            scores(N, [*points, 3])
    scores(N, [])

N = int(sys.argv[1])
show_scores(N)
