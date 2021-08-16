#
# See ../README.md
#

#
# Run as: Rscript ch-1.r < input-file
#

introot <- function (square) {
    return (floor (sqrt (square)))
}

stdin <- file ('stdin', 'r')
repeat {
    n <- readLines (stdin, n = 1)
    if (length (n) == 0) {
        break
    }
    n <- as.integer (n)
    if (n <= 2) {
        cat ("-1\n")
        next
    }

    n_sq <- n * n
    c    <- n + 1
    c_sq <- n_sq + 2 * n + 1

    while (2 * c - 1 <= n_sq) {
        b_sq <- c_sq - n_sq
        b    <- introot (b_sq)

        if (b_sq == b * b) {
            cat (n, b, c, "\n")
        }

        c_sq <- c_sq + 2 * c + 1
        c    <- c + 1
    }

    max_a = floor (n / sqrt (2))
    if (max_a < 3) {
        next
    }
    for (a in 3 : max_a) {
      # cat ("a = ", a, "\n")
        b_sq <- n_sq - a * a
        b    <- introot (b_sq)

        if (b_sq == b * b) {
            cat (a, b, n, "\n")
        }
    }
}
