#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-002
#

#
# Run as: Rscript ch-1.r < input-file
#

stdin <- file ('stdin', 'r')
repeat {
    n <- readLines (stdin, n = 1)
    if (length (n) == 0) {
        break
    }
    n = as.integer (n)
    cat (n, "\n")
}
