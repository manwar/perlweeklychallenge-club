#
# See ../README.md
#

#
# Run as: Rscript ch-2.r < input-file
#

substrings <- function (n, m, prefix, max) {
    if (nchar (n) == 0) {
        if (prefix > -1 && prefix < max && prefix %% m == 0) {
            return (1)
        }
        else {
            return (0)
        }
    }

    fc   <- as.numeric (substr (n, 0, 1))
    tail <- substr (n, 2, nchar (n))
    if (prefix < 0) {
        n_prefix <- fc
    } else {
        n_prefix <- 10 * prefix + fc
    }

    return (substrings (tail, m, n_prefix, max) +
            substrings (tail, m,   prefix, max))
}

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    parts <- strsplit (line, " ")
    list  <- parts [[1]]

    cat (substrings (list [[1]], as.numeric (list [[2]]), -1,
                                 as.numeric (list [[1]])), "\n")
}
