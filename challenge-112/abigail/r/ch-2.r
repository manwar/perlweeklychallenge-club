#
# See ../README.md
#

#
# Run as: Rscript ch-2.r < input-file
#

stdin <- file ('stdin', 'r')

sqrt5 <- sqrt (5)
phi   <- (1 + sqrt5) / 2

repeat {
    n <- readLines (stdin, n = 1)
    if (length (n) == 0) {
        break
    }
    cat (round (phi ^ (as.integer (n) + 1) / sqrt5), "\n", sep = "")
}
