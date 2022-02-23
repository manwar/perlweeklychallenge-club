#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
#

#
# Run as: Rscript ch-2.r < input-file
#

fac <- c (1)
for (n in 1 : 9) {
    fac <- c (fac, n * fac [[n]])
}

stdin <- file ('stdin', 'r')
repeat {
    num <- readLines (stdin, n = 1)
    if (length (num) == 0) {
        break
    }
    num <- as.integer (num)
    sum <- 0
    n   <- num
    while (n > 0) {
        sum <- sum + fac [[1 + (n %% 10)]]
        n   <- n %/% 10
    }
    if (num == sum) {
        cat (1, "\n")
    } else {
        cat (0, "\n")
    }
}
