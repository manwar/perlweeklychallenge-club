#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    #
    # Read the input, turn in into a graph:
    #  The first and last characters of the strings are the nodes.
    #  There is a directed edge in the graph from the first to the
    #  last character of a string.
    #
    delete graph
    delete nodes
    for (i = 1; i <= NF; i ++) {
        first = substr ($i, 1, 1)
        last  = substr ($i, length ($i))
        graph [first, last] = 1
        nodes [first]       = 1
        nodes [last]        = 1
    }

    #
    # Calculate the transitive closure using the Floyd-Warshall algorithm.
    #
    for (k in nodes) {
        for (i in nodes) {
            for (j in nodes) {
                if (graph [k, j] > 0 && graph [i, k] > 0) {
                    graph [i, j] = 1
                }
            }
        }
    }

    #
    # There's a loop iff there is a node which is reachable from itself.
    #
    out = 0
    for (i in nodes) {
        if (graph [i, i] > 0) {
            out = 1
        }
    }

    print (out)
}
