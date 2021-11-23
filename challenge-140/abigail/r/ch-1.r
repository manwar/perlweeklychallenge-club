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
    a <- strtoi (parts [[1]] [[1]], 2)
    b <- strtoi (parts [[1]] [[2]], 2)

    cat (as.integer (paste (as.integer (rev (intToBits (a + b))),
                            collapse = "")), "\n")
}
