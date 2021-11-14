#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

function intersects (x_low, x_high, y_low, y_high) {
    return (x_high >= y_low && x_low <= y_high)
}

{
    delete vertices
    #
    # Read input
    #
    for (i = 1; i <= NF; i ++) {
        gsub (/[^0-9]/, "", $i)
        vertices [i] = 0 + $i
    }

    #
    # Make sure vertices are low-high for each interval; swap if not
    #
    for (i = 1; i <= NF; i += 2) {
        if (vertices [i] > vertices [i + 1]) {
            t = vertices [i]
            vertices [i] = vertices [i + 1]
            vertices [i + 1] = t
        }
    }

    #
    # Check for intersections
    #
    for (i = 3; i <= NF; i += 2) {
        for (j = 1; j < i; j += 2) {
            if (intersects(vertices [i], vertices [i + 1],
                           vertices [j], vertices [j + 1])) {
                print (1)
                next
            }
        }
    }
    print (0)
}
