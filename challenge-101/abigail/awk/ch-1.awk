#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#


#
# Map 2-D coordinates to 1-D coordinates, as AWK doesn't
# have multidimensional arrays.
#
function idx (x, y, h, w) {
    return x * w + y + 1
}


BEGIN {
    RIGHT = 0
    UP    = 1
    LEFT  = 2
    DOWN  = 3
}

{
    #
    # Get the data; we're assuming it's one a single line,
    # seperated by white space.
    #
    split ($0, elements)

    #
    # Find optimal sizes: width w and height h
    # We start at the square root, and count downwards till we
    # have a divider.
    #
    n = length (elements)
    h = int (sqrt (n))
    for (;n % h;) {
        h --
    }
    w = n / h

    #
    # Fill the matrix, starting from the bottom left
    #
    min_x = 0
    max_x = h - 1
    min_y = 0
    max_y = w - 1
    x = max_x
    y = 0
    direction = RIGHT
    for (i = 1; i <= length (elements); i ++) {
        matrix [idx(x, y, h, w)] = elements [i]
        turn = 0
        if (direction == RIGHT) {
            if   (y >= max_y) {turn = 1; x --; max_x --}
            else {y ++}
        }
        if (direction == UP) {
            if   (x <= min_x) {turn = 1; y --; max_y --}
            else {x --}
        }
        if (direction == LEFT) {
            if   (y <= min_y) {turn = 1; x ++; min_x ++}
            else {y --}
        }
        if (direction == DOWN) {
            if   (x >= max_x) {turn = 1; y ++; min_y ++}
            else {x ++}
        }
        if (turn) {
            direction ++
            direction %= 4
        }
    }

    #
    # Find the max widths for each columns.
    #
    for (y = 0; y < w; y ++) {
        max = 0;
        for (x = 0; x < h; x ++) {
            l = length (matrix [idx(x, y, h, w)])
            if (l > max) {
                max = l
            }
        }
        widths [y + 1] = max
    }

    #
    # Print the matrix, with each column outlined
    #
    for (x = 0; x < h; x ++) {
        for (y = 0; y < w; y ++) {
            width = widths [y + 1]
            format = "%s%" width "s"
            printf (format, y == 0 ? "" : " ", matrix [idx(x, y, h, w)])
        }
        printf ("\n")
    }
}
