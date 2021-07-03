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

    cat (bitwOr (bitwOr (bitwAnd (n, bitwNot (0xFF)),
                         bitwShiftL (bitwAnd (n, 0x0F), 4)),
                         bitwShiftR (bitwAnd (n, 0xF0), 4)), "\n")
}
