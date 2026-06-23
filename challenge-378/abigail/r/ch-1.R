#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    max <- 0
    sec <- 0
    for (ch in sapply ((strsplit (line, split = "")) [[1]], utf8ToInt)) {
        if (ch >= utf8ToInt ("0") && ch <= utf8ToInt ("9")) {
            if (max < ch) {
                sec <- max
                max <- ch
            } else {
                if (max > ch && ch > sec) {
                    sec <- ch
                }
            }
        }
    }
    if (sec == 0) {
        cat ("-1\n")
    } else {
        cat (intToUtf8 (sec), "\n")
    }
}
