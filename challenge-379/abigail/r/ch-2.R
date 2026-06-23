#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    parts <- (strsplit (line, " ")) [[1]]
    base  <- as.numeric (parts [[1]])
    limit <- as.numeric (parts [[2]])
    for (n in 0 : limit) {
        size  <- 0
        n_c   <- n
        while (n_c > 0) {
            size <- size + 1
            n_c  <- n_c %/% base
        }
        sum <- 0
        n_c <- n
        while (n_c > 0) {
            sum <- sum + (n_c %% base) ^ size
            n_c <- n_c %/% base
        }
        if (sum == n) {
            cat (sum, end = "")
        }
    }
    cat ("\n")
}
