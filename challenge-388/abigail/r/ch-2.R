#!/opt/homebrew/bin/Rscript

stdin <- file ('stdin', 'r')
repeat {
    n <- readLines (stdin, n = 1)
    if (length (n) == 0) {
        break
    }
    sf <- 1
    for (i in 1 : as.numeric (n)) {
        sf <- i * sf + 1 - 2 * (i %% 2)
    }
    cat (sf, "\n")
}
