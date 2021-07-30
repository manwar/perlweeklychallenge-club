#
# See ../README.md
#

#
# Run as: Rscript ch-2.r < input-file
#

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    parts <- strsplit (line, " ")

    # 
    # Select x and y coordinates
    #
    x <- as.numeric (parts [[1]] [c (1, 3, 5, 7)])
    y <- as.numeric (parts [[1]] [c (2, 4, 6, 8)])

    # 
    # Indices of points
    #
    i1 <- c (1, 2, 3, 4, 1, 3)
    i2 <- c (2, 3, 4, 1, 2, 4)

    #
    # Calculate all distances in one operation
    # z [1 .. 4] will be sizes of the edges; z [5, 6] of the diagonales.
    #
    z <- (x [i1] - x [i2]) ^ 2 + (y [i1] - y [i2]) ^ 2

    if (z [1] == z [2] && z [2] == z [3] && z [3] == z [4] && z [5] == z [6]) {
        cat ("1\n")
    }
    else {
        cat ("0\n")
    }
}
