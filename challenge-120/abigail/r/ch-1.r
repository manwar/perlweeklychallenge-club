#
# See ../README.md
#

#
# Run as: Rscript ch-1.r < input-file
#

stdin <- file ('stdin', 'r')
repeat {
    n <- readLines (stdin, n = 1)
    if (length (n) == 0) {
        break
    }
    n = as.integer (n)

    cat (bitwOr (bitwShiftL (bitwAnd (n, 0x55), 1),
                 bitwShiftR (bitwAnd (n, 0xAA), 1)), "\n")
}
