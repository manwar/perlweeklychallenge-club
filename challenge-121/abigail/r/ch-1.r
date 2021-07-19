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
    parts <- strsplit (line, " ")
    m     <- as.numeric (parts [[1]] [[1]])
    n     <- as.numeric (parts [[1]] [[2]])

    cat (bitwXor (m, (bitwShiftL (1, n - 1))), "\n")
}
