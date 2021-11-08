#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    #
    # Read in the data; create a graph: the first and last character
    # of each string are the nodes, and there is a directed edge
    # from the beginning to the end of the string.
    #
    strings = line . split ()
    nodes   = {}
    graph   = {}
    for string in strings:
        first = string [:1]
        last  = string [-1:]
        nodes [first] = 1
        nodes [last]  = 1
        if not first in graph:
            graph [first] = {}
        if not last in graph:
            graph [last]  = {}
        graph [first] [last] = 1

    #
    # Calculate the transitive closure using Floyd-Warshall
    #
    for k in nodes:
        for i in nodes:
            for j in nodes:
                if not j in graph [j]:
                    if k in graph [i] and j in graph [k]:
                        graph [i] [j] = 1

    #
    # There is a cycle iff at least one node can be reached from itself
    #
    out = 0
    for i in nodes:
        if i in graph [i]:
            out = 1

    print (out)
