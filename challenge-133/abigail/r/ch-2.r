#
# See ../README.md
#

#
# Run as: Rscript ch-2.r < input-file
#

small_primes <- c (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31)
base         <- 10
count        <- 10

factors <- function (n) {
    f <- c ()
    for (i in 1 : length (small_primes)) {
        prime <- small_primes [i]
        while (n %% prime == 0) {
            f [1 + length (f)] <- prime
            n <- n / prime
        }
        if (n == 1) {
            break
        }
    }
    if (n > 1) {
        f [1 + length (f)] <- n
    }
    return (f)
}

digitsum <- function (numbers) {
    sum <- 0
    for (number in numbers) {
        while (number > 0) {
            sum    <- sum + (number %% base)
            number <- number %/% base
        }
    }
    return (sum)
}


num <- 0
while (count > 0) {
    num <- num + 1
    f   <- factors (num)
    if (length (f) > 1 && digitsum (c (num)) == digitsum (f)) {
        cat (num, "\n")
        count <- count - 1
    }
}
