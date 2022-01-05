#
# See ../README.md
#

#
# Run as: Rscript ch-1.r < input-file
#

ugly   <- c (1)
next_2 <- 1
next_3 <- 1
next_5 <- 1
count  <- 1

stdin <- file ('stdin', 'r')
repeat {
    n <- readLines (stdin, n = 1)
    if (length (n) == 0) {
        break
    }
    n = as.integer (n)

    while (count < n) {
        count = count + 1
        ugly [count] = min (c (2 * ugly [next_2], 3 * ugly [next_3],
                               5 * ugly [next_5]))

        if (2 * ugly [next_2] <= ugly [count]) {next_2 <- next_2 + 1}
        if (3 * ugly [next_3] <= ugly [count]) {next_3 <- next_3 + 1}
        if (5 * ugly [next_5] <= ugly [count]) {next_5 <- next_5 + 1}
    }
    cat (format (ugly [n], digits = 15), "\n")
}
