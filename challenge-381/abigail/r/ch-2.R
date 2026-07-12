#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    numbers <- as.numeric ((strsplit (line, " ")) [[1]])
    min   <- 0
    max   <- 0
    min_c <- 0
    max_c <- 0
    for (number in numbers) {
        if (min_c == 0 || number < min) {min_c <- 0; min <- number}
        if (max_c == 0 || number > max) {max_c <- 0; max <- number}
        if (min == number) {min_c <- min_c + 1}
        if (max == number) {max_c <- max_c + 1}
    }
    cat (length (numbers) - min_c - ifelse (min == max, 0, max_c), "\n")
}
