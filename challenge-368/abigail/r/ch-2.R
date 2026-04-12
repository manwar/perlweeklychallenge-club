#!/opt/homebrew/bin/Rscript

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    parts  <- strsplit (line, " ")
    number <- strtoi (parts [[1]] [[1]])
    mode   <- strtoi (parts [[1]] [[2]])

    diff_factors <- 0
    factors      <- 0

    n <- 2
    while (n * n <= number) {
        if (number %% n == 0) {
            diff_factors <- diff_factors + 1
            while (number %% n == 0) {
                factors <- factors + 1
                number  <- number  / n
            }
        }
        if (n == 2) {
            n <- n + 1
        }
        else {
            n <- n + 2
        }
    }

    if (number != 1) {
        diff_factors <- diff_factors + 1
        factors      <- factors      + 1
    }

    if (mode == 1) {
        cat (factors)
    }
    else {
        cat (diff_factors)
    }
    cat ("\n")
}
