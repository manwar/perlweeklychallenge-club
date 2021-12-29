#
# See ../README.md
#

#
# Run as: Rscript ch-2.r < input-file
#

is_palindrome <- function (string) {
    l <- nchar (string)
    ifelse (l < 2,                                                TRUE,
    ifelse (substring (string, 1, 1) != substring (string, l, l), FALSE,
            is_palindrome (substring (string, 2, l - 1))))
}

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    out <- c ()
    for (i in 1 : nchar (line)) {
        for (j in i : nchar (line)) {
            string <- substring (line, i, j)
            if (is_palindrome (string)) {
                #
                # I fear this is quadratic
                #
                if (!(string %in% out)) {
                    out <- c (out, string)
                }
            }
        }
    }
    cat (paste (out, sep = " "), "\n")
}
