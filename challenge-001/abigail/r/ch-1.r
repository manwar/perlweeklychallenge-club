#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
#

#
# Run as: Rscript ch-1.r < input-file
#

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    cat (gsub ("e", "E", line), "\n")
    cat (nchar (gsub ("[^e]", "", line)), "\n")
}
