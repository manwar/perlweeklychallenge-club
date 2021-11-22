#
# See ../README.md
#

#
# Run as: Rscript ch-1.r < input-file
#

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    parts  <- strsplit (line, " ")
    list   <- as.numeric (parts [[1]])
    sorted <- 1
    if (length (list) > 1) {
        for (i in 2 : length (list)) {
            if (list [i - 1] > list [i]) {
                sorted <- 0
            }
        }
    }
    cat (sorted, "\n")
}
