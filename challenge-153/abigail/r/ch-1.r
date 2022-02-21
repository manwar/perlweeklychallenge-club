#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
#

#
# Run as: Rscript ch-1.r
#

sum <- 1
fac <- 1

cat (sum)

for (n in 1 : 9) {
    fac <- fac * n
    sum <- sum + fac
    cat ("", sum)
}

cat ("\n")
