#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    sum <- 0
    i   <- 0
    for (ch in (strsplit (line, "")) [[1]]) {
        i   <- i + 1
        sum <- sum + i * (utf8ToInt ("z") - utf8ToInt (ch) + 1)
    }
    cat (sum, "\n")
}
