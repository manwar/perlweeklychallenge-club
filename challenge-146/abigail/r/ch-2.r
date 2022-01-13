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
    parts <- strsplit (line, '/')
    a <- as.numeric (parts [[1]] [[1]])
    b <- as.numeric (parts [[1]] [[2]])
    for (i in 1 : 2) {
        if (a < b) {
            b = b - a
        }
        else {
            a = a - b
        }
        if (a == 0 || b == 0) {
            break
        }
        cat (a, '/', b, ' ', sep = '')
    }
    cat ("\n")
}
