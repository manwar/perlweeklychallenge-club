#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
#

#
# Run as: Rscript ch-2.r
#

primes <- c(2, 3, 5, 7, 11, 13, 17, 19)

for (n in 1 : 500) {
    has_square <- FALSE
    for (p in primes) {
        if (n %% (p * p) == 0) {
            has_square <- TRUE
        }
    }
    if (!has_square) {
        cat (n, "")
    }
}
cat ("\n")
