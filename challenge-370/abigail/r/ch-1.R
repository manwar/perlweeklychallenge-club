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
    parts      <- strsplit (tolower (line), " *// *")
    paragraph  <- parts [[1]] [[1]]
    banned_str <- parts [[1]] [[2]]

    #
    # Extract the banned words
    #
    banned_w   <- strsplit (banned_str, " +")
    banned     <- list ()
    for (ban in banned_w [[1]]) {
        banned <- c (banned, ban)
    }

    #
    # Replace all sequences of non-letters with a single space
    #
    paragraph <- gsub ("[^[:alpha:]]+", " ", paragraph)

    #
    # For all words in the paragraph, keep the ones which
    # are not banned
    #
    words <- strsplit (paragraph, " ")
    valid <- list ()
    for (word in words [[1]]) {
        if (!(word %in% banned)) {
            valid <- c (valid, word)
        }
    }

    #
    # Find the word which occurs the most frequently. This is an inefficient,
    # quadratic algorithm.
    #
    max       <- ""
    max_count <- 0
    for (v1 in valid) {
        count <- 0
        for (v2 in valid) {
            if (v1 == v2) {
                count <- count + 1
            }
        }
        if (count > max_count) {
            max       <- v1
            max_count <- count
        }
    }
    cat (max, "\n")
}
