#
# See ../README.md
#

#
# Run as: Rscript ch-2.r < input-file
#

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    parts <- strsplit (line, " ")

    m <- as.numeric (parts [[1]] [[1]])
    n <- as.numeric (parts [[1]] [[2]])

    seen <- replicate (m * n, 0)

    for (i in 1 : m) {
        for (j in 1 : n) {
            seen [[i * j]] <- 1
        }
    }

    cat (sum (seen), "\n")
}
