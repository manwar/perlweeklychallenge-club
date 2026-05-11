#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    line  <- gsub (" ",   "", line)         # Remove spaces
    line  <- gsub ("[.]", "", line)         # Remove dots
    parts <- (strsplit (line, ";")) [[1]]   # Split on ;
    if (parts [[1]] == parts [[2]]) {       # Equal?
        cat ("true\n")
    }
    else {
        cat ("false\n")
    }
}
