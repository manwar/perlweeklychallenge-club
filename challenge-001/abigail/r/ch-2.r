#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
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
    for (i in 1 : max) {
        if (i %% 15 == 0) {
            cat ("fizzbuzz\n")
            next
        }
        if (i %%  5 == 0) {
            cat (    "buzz\n")
            next
        }
        if (i %%  3 == 0) {
            cat ("fizz\n"    )
            next
        }
        cat (i, "\n")
    }
}
