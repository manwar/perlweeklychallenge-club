#
# See ../README.md
#

#
# Run as: Rscript ch-2.r < input-file
#

reverse <- function (num) {
    rev <- 0
    while (num > 0) {
        rev <- rev * 10
        rev <- rev + (num %% 10)
        num <- num %/% 10
    }
    return (rev)
}

ly <- function (n) {
    if (n >= 10000000) {
        1
    } else if (n == reverse (n)) {
        0
    } else {
        ly (n + reverse (n))
    }
}


stdin <- file ('stdin', 'r')
repeat {
    n <- readLines (stdin, n = 1)
    if (length (n) == 0) {
        break
    }
    n = as.integer (n)
    cat (ly (n), "\n")
}
