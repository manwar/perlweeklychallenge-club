#!/opt/homebrew/bin/Rscript

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    parts <- strsplit (line, " ")
    input <- parts [[1]] [[1]]
    digit <- parts [[1]] [[2]]

    #
    # Find the first occurrence of the digit which is followed by
    # a larger one, and remove it, if any
    #
    found <- 0
    if (digit != "9") {
        ndigit <- 1 + strtoi (digit)
        pat    <- paste (digit, "([", ndigit, "-9])", sep = "")
        res    <- regexpr (pat, input)
        match  <- res [[1]] [[1]]
        if (match >= 0) {  # There is a match
            found <- 1
            input <- sub (pat, "\\1", input)
        }
    }

    #
    # If the block above didn't remove a digit, remove its last
    # occurrence in the number
    #
    if (!found) {
        pat <- paste ("(.*)", digit, sep = "")
        input <- sub (pat, "\\1", input)
    }

    cat (input, "\n")
}
