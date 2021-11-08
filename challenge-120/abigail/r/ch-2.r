#
# See ../README.md
#

#
# Run as: Rscript ch-2.r < input-file
#

DIFF_PER_MINUTE <-  11
MIN_PER_HOUR    <-  60
FULL_CIRCLE     <- 720

stdin <- file ('stdin', 'r')
repeat {
    time <- readLines (stdin, n = 1)
    if (length (time) == 0) {
        break
    }
    parts   <- strsplit (time, ":")
    hours   <- as.numeric (parts [[1]] [[1]])
    minutes <- as.numeric (parts [[1]] [[2]])
    angle   <- (DIFF_PER_MINUTE * (hours * MIN_PER_HOUR + minutes)) %%
                                           FULL_CIRCLE
    if (2 * angle >= FULL_CIRCLE) {
        angle <- FULL_CIRCLE - angle
    }
    cat (angle / 2, "\n")
}
