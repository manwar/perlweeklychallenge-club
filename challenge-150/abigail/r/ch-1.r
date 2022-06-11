#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
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
    fibs <- strsplit (line, " ")
    fib_prev <- fibs [[1]] [[1]]
    fib_last <- fibs [[1]] [[2]]
    c <- 0
    while (nchar (fib_last) < 51) {
        fib_tmp  <- fib_last
        fib_last <- paste0 (fib_prev, fib_last)
        fib_prev <- fib_tmp
    }
    cat (substr (fib_last, 51, 51), "\n")
}
