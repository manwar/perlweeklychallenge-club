#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-002
#

#
# Run as: Rscript ch-2.r < input-file
#

from_base <- FALSE
to_base   <- FALSE

args <- commandArgs ()
for (i in 1 : length (args)) {
    if (args [i] == "-f") {
        from_base <- TRUE
    }
    if (args [i] == "-t") {
        to_base <- TRUE
    }
}

to_base_35 <- function (num) {
    glyphs <- c (0 : 9, LETTERS)
    out <- c ()
    while (num > 0) {
        rem <- num %% 35
        num <- num %/% 35
        out <- c (glyphs [rem + 1], out)
    }
    paste0 (out, collapse = "")
}

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    if (from_base) {
        cat (strtoi (line, 35), "\n")
    }
    if (to_base) {
        cat (to_base_35 (as.numeric (line)), "\n")
    }
}
