#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    rev <- ""
    for (ch in (strsplit (line, "")) [[1]]) {
        rev <- paste (ch, rev, sep = "")
    }
    cat (rev, "\n")
}
