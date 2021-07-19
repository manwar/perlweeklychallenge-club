#
# See ../README.md
#

#
# Run as: Rscript ch-1.r < input-file
#

stdin <- file ('stdin', 'r')
s <- 0
c <- 0
repeat {
    n <- readLines (stdin, n = 1)
    if (length (n) == 0) {
        break
    }
    cat ((s <- s + as.integer (n)) / (c <- c + 1), "\n")
}
