#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    #
    # Parse input
    #
    parts  <- strsplit (line, " ")
    str    <-         parts [[1]] [[1]]
    size   <- strtoi (parts [[1]] [[2]])
    filler <-         parts [[1]] [[3]]

    #
    # Add 'size - 1' filler characters to the string
    #
    str <- paste (str, strrep (filler, size - 1), sep = "")

    #
    # While the string has at least 'size' characters left, 
    # remove 'size' characters from the string and add 
    # them to the output array
    #
    out <- c ()
    while (nchar (str) >= size) {
        out <- append (out, substr (str, 1, size))
        str <- substr (str, size + 1, nchar (str))
    }

    #
    # Print the output
    # 
    cat (out, "\n")
}
