#!/usr/bin/env python3

# Challenge 121
#
# TASK #2 > The Travelling Salesman
# Submitted by: Jorg Sommrey
# You are given a NxN matrix containing the distances between N cities.
#
# Write a script to find a round trip of minimum length visiting all N cities
# exactly once and returning to the start.
#
# Example
# Matrix: [0, 5, 2, 7]
#         [5, 0, 5, 3]
#         [3, 1, 0, 6]
#         [4, 5, 4, 0]
#
# Output:
#         length = 10
#         tour = (0 2 1 3 0)

import sys

def read_dist():
    dist = []
    for line in sys.stdin:
        row = [int(x) for x in line.split()]
        dist.append(row)
    return dist

def shortest_tour(dist):
    short_length = 100000
    short_path = []

    def tour(length, path):
        nonlocal short_length, short_path

        cities = list(set(range(0, len(dist))) - set(path))
        cities.sort()

        if len(cities)==0:
            # no more cities to visit
            length += dist[path[-1]][path[0]]
            path.append(path[0])
            if length < short_length:
                short_length, short_path = length, path
        else:
            # try each city
            for city in cities:
                tour(length + dist[path[-1]][city], [*path, city])

    tour(0, [0])
    return (short_length, short_path)

length, path = shortest_tour(read_dist())
print("length =", length)
print("tour = ("+ " ".join([str(x) for x in path]) + ")")
