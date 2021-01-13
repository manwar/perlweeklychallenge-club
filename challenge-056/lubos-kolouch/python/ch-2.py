#!/usr/bin/env python
""" https://perlweeklychallenge.org/blog/perl-weekly-challenge-056/
    Task 2
    You are given a binary tree and a sum, write a script to find if the tree has a path such that adding up all the values along the path equals the given sum. Only complete paths (from root to leaf node) may be considered for a sum.
"""

import networkx as nx

g = nx.DiGraph()

g.add_edge(5, 4)
g.add_edge(4, 11)
g.add_edge(11, 7)
g.add_edge(11, 2)
g.add_edge(5, 8)
g.add_edge(8, 13)
g.add_edge(8, 9)
g.add_edge(9, 1)

start = 5
my_sum = 22

external_vertices = (x for x in g.nodes() if g.out_degree(x)==0 and g.in_degree(x)==1)

for vert in external_vertices:
    path = nx.shortest_path(g, start, vert)
    if sum(path) == my_sum:
        print(path)
