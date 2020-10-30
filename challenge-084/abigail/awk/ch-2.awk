#
# You are given matrix of size m x n with only 1 and 0.
#
# Write a script to find the count of squares having all four corners set as 1.
#

BEGIN {
    FS = " ";  # Split input on spaces.
    x  = 0;    # Array indices start at 1.
}

#
# Read the input, store it in array matrix.
#
{
    x ++;
    for (y = 1; y <= NF; y ++) {
        matrix [x, y] = +$y;
    }
    y = NF;
}

END {
    #
    # Now, x and y are the maximum index values.
    #
    count = 0;

    #
    # Cubic algorithm, counting all possible squares.
    #
    for (i = 1; i <= x; i ++) {
        for (j = 1; j <= y; j ++) {
            if (matrix [i, j]) {
                for (k = 1; i + k <= x && j + k <= y; k ++) {
                    if (matrix [i,     j + k] &&
                        matrix [i + k, j    ] &&
                        matrix [i + k, j + k]) {
                        count ++;
                    }
                }
            }
        }
    }
    print count;
}
