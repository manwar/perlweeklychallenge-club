#
# See ../README.md
#

#
# Run as: Rscript ch-2.r
#

BASE  <- 10
COUNT <-  5

is_long <- function (number) {
    seen <- vector ("numeric", number)
    rest <- 0
    for (i in 2 : number) {
        rest <- (rest * BASE + BASE - 1) %% number
        if (seen [[1 + rest]] > 0) {
            return (0)
        }
        seen [[1 + rest]] = 1
    }
    return (1)
}

number <- 1
while (COUNT > 0) {
    number <- number + 1
    if (BASE %% number == 0) {
        next
    }
    if (is_long (number) == 1) {
        cat (number, "\n")
        COUNT <- COUNT - 1
    }
}
