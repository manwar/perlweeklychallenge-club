#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-003
#

#
# Run as: Rscript ch-2.r < input-file
#

stdin <- file ('stdin', 'r')
repeat {
    max <- readLines (stdin, n = 1)
    if (length (max) == 0) {
        break
    }
    max = as.integer (max)
    row <- c (1)
    cat (row, "\n")
    for (r in 1 : max) {
        row <- c (0, row) + c (row, 0)
        cat (row, "\n")
    }
}
