#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-154
#

#
# Run as: Rscript ch-1.r < input-file
#

suppressPackageStartupMessages (
    library (hash)
)

p <- hash ()
p1 <- c ("PERL", "PELR", "PREL", "PRLE", "PLER", "PLRE",
         "EPRL", "EPLR", "ERPL", "ERLP", "ELPR", "ELRP",
         "REPL", "RELP", "RPEL", "RPLE", "RLEP", "RLPE",
         "LERP", "LEPR", "LREP", "LRPE", "LPER", "LPRE")

for (x in p1) {
    .set (p, x, 1)
}

stdin <- file ('stdin', 'r')
repeat {
    word <- readLines (stdin, n = 1)
    if (length (word) == 0) {
        break
    }
    del (word, p)
}

cat (keys (p), "\n")
