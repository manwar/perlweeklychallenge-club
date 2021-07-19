#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

#
# Given a path, return its length
#
function path_length (path, path_nodes, l, i) {
    l = 0
    split (path, path_nodes, " ")
    for (i = 1; i < length (path_nodes); i ++) {
        l += matrix [path_nodes [i - 1], path_nodes [i]]
    }
    return l
}

#
# Find the shorted path between 'from' and 'to', visiting
# all the nodes, except the ones already in 'path'.
#
function shortest_path (from, to, path,
                        visited, path_nodes, shortest, sh_path, l, n, i) {
    split (path, path_nodes, " ")

    #
    # If 'path' already has all the nodes, close the path and return
    #
    if (length (path_nodes) == NR) {
        return path " " to
    }

    #
    # For all the nodes in the path, mark them in 'visited'
    #
    for (i = 0; i < length (path_nodes); i ++) {
        visited [path_nodes [i]] = 1
    }


    #
    # Try all posibilities, keep the shortest
    #
    shortest = max
    for (n = 0; n < NR; n ++) {
        if (!visited [n]) {
            new_path = shortest_path(n, to, path " " n)
            l = path_length(new_path)
            if (shortest > l) {
                shortest = l
                sh_path = new_path
            }
        }
    }

    return sh_path
}
            


BEGIN {
    line = 0
    max  = 0  # Sum off all path, *no* path will be longer.
}

{
    #
    # Read in the data
    #
    for (i = 1; i <= NF; i ++) {
        matrix [line, i - 1] = $i
        max += $i
    }
    line ++
}

END {
    path = shortest_path(0, 0, "0")
    print (path_length(path))
    print (path)
}
