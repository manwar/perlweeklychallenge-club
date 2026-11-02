#!/opt/homebrew/bin/Rscript

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    sum   <- 0
    count <- 0
    for (number in as.numeric ((strsplit (line, " ")) [[1]])) {
        if (number %% 6 == 0) {
            sum   <- sum   + number
            count <- count + 1
        }
    }

    res <- 0
    if (sum) {
        res = round (sum / count)
    }
    cat (res, "\n")
}
