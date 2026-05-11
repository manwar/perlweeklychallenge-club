#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }

    #
    # Remove quotes
    #
    line    <- gsub ('"', '', line)

    #
    # Count the number of spaces: we explode the string into individual
    # characters, then iterate over it, counting spaces
    #
    letters <- (strsplit (line, "")) [[1]]
    spaces  <- 0
    for (ch in letters) {
        if (ch == " ") {
            spaces <- spaces + 1
        }
    }

    #
    # Split into words; we first remove leading and trailing whitespace
    #
    words   <- (strsplit (trimws (line), " +")) [[1]]

    #
    # Number of gaps between the words
    #
    gaps    <- length (words) - 1

    #
    # Calculate the number of spaces needed
    #
    per_gap <- if (gaps > 0) spaces %/% gaps else 0
    end     <- spaces - gaps * per_gap

    #
    # Print the results
    #
    cat ('"', paste (words, collapse = strrep (" ", per_gap)),
                                       strrep (" ", end), '"', "\n", sep = "") 
}
