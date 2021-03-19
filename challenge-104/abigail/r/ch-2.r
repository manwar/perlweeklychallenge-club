#
# See ../README.md
#

#
# Run as: Rscript ch-2.r
#

input <- file ('stdin', 'r')

tokens   <- 12
max_take <-  3

while (tokens > 0) {
    cat ("How many tokens do you take? ")
    cat (sprintf ("(%2d tokens are left) ", tokens))
    take <- readLines (input, n = 1)
    take <- as.integer (take)
    if (1 <= take && take <= max_take) {
        takes <- max_take + 1 - take
        s <- if (takes == 1) "" else "s"
        cat (sprintf ("Computer takes %d token%s\n", takes, s))
        tokens <- tokens - (max_take + 1)
    }
}

cat ("Computer wins\n")
