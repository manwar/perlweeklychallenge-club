#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
#

#
# Run as: Rscript ch-1.r < input-file
#

suppressPackageStartupMessages (
    library (hash)
)

digit_sum <- function (n) {
    base <- 10
    sum  <-  0
    while (n > 0) {
        sum <- sum + n %% base
        n   <- n %/% base
    }
    return (sum)
}

fib <- hash ()
fib_prev <- 0
fib_last <- 1
.set (fib, fib_prev, TRUE)
.set (fib, fib_last, TRUE)

is_fib <- function (n) {
    while (fib_last < n) {
        t        <- fib_last
        fib_last <- fib_last + fib_prev
        fib_prev <- t
        .set (fib, fib_last, TRUE)
    }

    return (has.key (as.character (n), fib))
}

stdin <- file ('stdin', 'r')
repeat {
    n <- readLines (stdin, n = 1)
    if (length (n) == 0) {
        break
    }
    n = as.integer (n)

    k <- 0
    while (n > 0) {
        if (is_fib (digit_sum (k))) {
            cat (k, "")
            n <- n - 1
        }
        k <- k + 1
    }
    cat ("\n")
}
