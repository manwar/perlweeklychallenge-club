#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
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
    h <- c (as.numeric (strsplit (line, " ") [[1]]), 0, 0)
    for (i in seq (length (h) - 2, 3, -1)) {
        h [[i]] <- max (c (h [[i]] + h [[i + 2]], h [[i + 1]]))
    }
    cat (h [[1]] + h [[3]], "\n")
}
