#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }

    chars <- (strsplit (line, "")) [[1]]      # Array of characters
    max   <- -1                               # Track max distance

    for (f in 1 : (length (chars) - 1)) {     # For each character, ...
        for (l in length (chars) : f) {       # find matching character
            if (chars [[f]] == chars [[l]]) { # from the end
                if (l - f - 1 > max) {        # If larger distance,
                    max <- l - f - 1          # remember it
                }
                break
            }
        }
    }
    cat (max, "\n")
}
