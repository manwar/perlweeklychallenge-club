#
# See ../README.md
#

#
# Run as: Rscript ch-2.r < input-file
#

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    parts <- strsplit (line, " ")
    list  <- as.numeric (parts [[1]])
    i     <- list [[1]]
    j     <- list [[2]]
    k     <- list [[3]]
    n     <- 0
    while (k > 0) {
        n <- n + 1
        s <- floor (sqrt (n))
        for (d in 1 : s) {
            if (n %% d == 0) {
                if (d <= i && n / d <= j) {k = k - 1}
                if (d <= j && n / d <= i) {k = k - 1}
                if (n == d * d)           {k = k + 1}
            }
        }
    }
    cat (sprintf ("%d\n", n))
}
