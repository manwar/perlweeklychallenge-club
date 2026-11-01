#!/opt/homebrew/bin/Rscript

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    numbers <- as.numeric ((strsplit (line, " ")) [[1]])
    sort (numbers)

    sum <- 0
    for (num in numbers) {
        sum <- sum + num
    }

    res <- 1
    if (sum > 0) {
        res <- 1 + sum %/% length (numbers)
    }

    for (num in numbers) {
        if (num == res) {res <- res + 1}
        if (num >  res) {break}
    }

    cat (res, "\n")
}
