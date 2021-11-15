#
# See ../README.md
#

#
# Run as: Rscript ch-2.r < input-file
#


can_split <- function (target, number) {
    if (target >  number || target < 0) {return (0)}
    if (target == number)               {return (1)}

    pow_10 <- 10

    while (pow_10 <= number) {
        if (can_split (target - (number %% pow_10), number %/% pow_10)) {
            return (1)
        }
        pow_10 <- pow_10 * 10
    }

    return (0)
}



stdin <- file ('stdin', 'r')
repeat {
    number <- readLines (stdin, n = 1)
    if (length (number) == 0) {
        break
    }
    number = as.integer (number)
    if (number > 1 & can_split (sqrt (number), number)) {
        cat ("1\n")
    }
    else {
        cat ("0\n")
    }
}
