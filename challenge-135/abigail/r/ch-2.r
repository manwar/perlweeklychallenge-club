#
# See ../README.md
#

#
# Run as: Rscript ch-2.r < input-file
#

ord.0 <- as.integer (charToRaw ("0"))
ord.9 <- as.integer (charToRaw ("9"))
ord.A <- as.integer (charToRaw ("A"))
w     <- c (1, 3, 1, 7, 3, 9, 1)

stdin <- file ('stdin', 'r')
repeat {
    n <- readLines (stdin, n = 1)
    if (length (n) == 0) {
        break
    }
    valid <- 1
    c <- grep ("^[0-9BCDFGHJKLMNPQRSTVWXYZ]{6}[0-9]$", n)
    if (length (c) == 0) {
        cat ("0\n")
        next
    }

    check <- 0
    index <- 0
    for (char in strsplit (n, split = "") [[1]]) {
        a <- as.integer (charToRaw (char))
        a <- a - (if (a <= ord.9) ord.0 else ord.A)
        index <- index + 1
        check <- check + a * w [index]
    }
    cat (if (check %% 10 == 0) 1 else 0, "\n")
}
