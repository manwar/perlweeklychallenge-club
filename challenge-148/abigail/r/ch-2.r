#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
#

#
# Run as: Rscript ch-2.r
#

COUNT <- 5
A     <- 1
B     <- 2
C     <- 3
SUM   <- 4
out <- list ()
for (i in 1 : COUNT) {
    out [[i]] = c (999999, 999999, 999999, 3 * 999999)
}

max_index <- 1
k         <- 0

while (3 * k + 2 < out [[max_index]] [[SUM]]) {
    a  <- 3 * k + 2
    f1 <-     k + 1
    f2 <- 8 * k + 5

    d1 <- c ()
    for (i in 1 : f1) {
        if (i * i > f1) {
            break
        }
        if (f1 %% i == 0) {
            d1 <- c (d1, i)
            if (i != f1 / i) {
                d1 <- c (d1, f1 / i)
            }
        }
    }


    d2 <- c ()
    for (i in 1 : f2) {
        if (i * i > f2) {
            break
        }
        if (f2 %% i == 0) {
            s1 <- floor (sqrt (i))
            s2 <- floor (sqrt (f2 / i))
            if (s1 * s1 == i) {
                d2 <- c (d2, s1)
            }
            if (s2 * s2 == f2 / i && s1 != s2) {
                d2 <- c (d2, s2)
            }
        }
    }

    for (d1v in d1) {
        for (d2v in d2) {
            b <- d1v * d2v
            c <- f1 * f1 * f2 / (b * b)
            if (a + b + c < out [[max_index]] [[SUM]]) {
                seen <- FALSE
                for (i in 1 : COUNT) {
                    if (out [[i]] [[A]] == a && out [[i]] [[B]] == b) {
                        seen <- TRUE
                    }
                }
                if (seen) {
                    break
                }

                out [[max_index]] = c (a, b, c, a + b + c)

                max_index <- 1
                max_sum   <- out [[max_index]] [[SUM]]

                for (i in 2 : COUNT) {
                    if (max_sum < out [[i]] [[SUM]]) {
                        max_sum <- out [[i]] [[SUM]]
                        max_index <- i
                    }
                }
            }
        }
    }

    k <- k + 1
}

for (i in 1 : COUNT) {
    cat (out [[i]] [[A]], out [[i]] [[B]], out [[i]] [[C]], "\n")
}
