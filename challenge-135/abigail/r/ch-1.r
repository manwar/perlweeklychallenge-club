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
    n <- sub ("^[-+]", "", n)
    matches <- grep ("[^0-9]", n)
    if (length (matches) != 0) {
        cat ("not an integer\n")
        next
    }
    if (nchar (n) %% 2 == 0) {
        cat ("even number of digits\n")
        next
    }
    if (nchar (n) < 3) {
        cat ("too short\n")
        next
    }
    cat (substr (n, 1 + (nchar (n) - 3) / 2, (nchar (n) + 3) / 2), "\n")
}
