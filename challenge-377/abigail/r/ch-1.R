#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    chars <- (strsplit (line, "")) [[1]]

    match <- FALSE
    for (i in 1 : (length (chars) - 1)) {
        c1 <- chars [[i]]
        c2 <- chars [[i + 1]]
        for (j in (i + 1) : length (chars)) {
            d1 <- chars [[j]]
            d2 <- chars [[j - 1]]
            if (c1 == d1 && c2 == d2) {
                match <- TRUE
                break
            }
        }
        if (match) {
            break
        }
    }
    if (match) {
        cat ("true\n")
    }
    else {
        cat ("false\n")
    }
}
