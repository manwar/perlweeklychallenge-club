#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    #
    # Check line length
    #
    if (nchar (line) != 5) {
        break
    }

    #
    # Split the string into characters,
    # and map them to their Unicode code points
    #
    chars <- sapply ((strsplit (line, split = "")) [[1]], utf8ToInt)

    #
    # Validate the string
    #
    if (chars [[1]]  < utf8ToInt ("a") || chars [[1]] > utf8ToInt ("h") ||
        chars [[2]]  < utf8ToInt ("1") || chars [[2]] > utf8ToInt ("8") ||
        chars [[3]] != utf8ToInt (" ") ||
        chars [[4]]  < utf8ToInt ("a") || chars [[4]] > utf8ToInt ("h") ||
        chars [[5]]  < utf8ToInt ("1") || chars [[5]] > utf8ToInt ("8")) {
        break
    }

    cat (ifelse (xor ((chars [[1]] %% 2) == (chars [[2]] %% 2),
                      (chars [[4]] %% 2) == (chars [[5]] %% 2)),
                      "false\n", "true\n"))
}
