#
# See ../README.md
#

#
# Run as: Rscript ch-1.r < input-file
#

SUNDAY    <- 0
MONDAY    <- 1
TUESDAY   <- 2
WEDNESDAY <- 3
THURSDAY  <- 4
FRIDAY    <- 5
SATURDAY  <- 6

lookup <- array (c (261, 262,
                    260, 261,
                    260, 260,
                    261, 261,
                    261, 262,
                    261, 262,
                    261, 262), dim = c (2, 7))

anchors <- c (TUESDAY, SUNDAY, FRIDAY, WEDNESDAY)

doomsday <- function (year) {
    anchor <- anchors [[1 + ((year %/% 100) %% 4)]]
    y      <- year %% 100
    dday   <- ((((y %/% 12) + (y %% 12) + ((y %% 12) %/% 4)) + anchor) %% 7)
    return (dday)
}

is_leap <- function (year) {
    if ((year %% 400 == 0) | (year %% 4 == 0) & (year %% 100 != 0)) {
        return (1)
    }
    return (0)
}



stdin <- file ('stdin', 'r')
repeat {
    year <- readLines (stdin, n = 1)
    if (length (year) == 0) {
        break
    }
    year = as.integer (year)
    cat (lookup [[1 + is_leap (year), 1 + doomsday (year)]], "\n")
}
