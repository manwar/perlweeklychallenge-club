#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
#

#
# Run as: Rscript ch-2.r
#

suppressPackageStartupMessages (
    library (hash)
)

pentagon <- hash ()
p        <- 0
n        <- 0
done     <- FALSE

while (!done) {
    p <- p + n + n + n + 1
    n <- n + 1
    .set (pentagon, p, 1)

    for (seen in keys (pentagon)) {
        seen <- as.numeric (seen)
        if (seen + seen <= p &&
              all (has.key (c (as.character (p - seen),
                               as.character (p - seen - seen)), pentagon))) {
            cat (seen, p - seen, "\n")
            done = TRUE
        }
        if (done) {
            break
        }
    }
}
