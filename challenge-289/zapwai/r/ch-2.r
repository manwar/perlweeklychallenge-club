jumble <-function(word) {
    if (nchar(word) < 4) {
        return(word)
    }
    let <- strsplit(word, "")[[1]]
    start <- let[1]
    end <- let[length(let)]
    let <- let[-length(let)]
    let <- let[-1]
    order <- c()
    while (length(order) < length(let)) {
	x <- sample(1:length(let), 1)
        if (!x %in% order)
            order <- append(order, x)
    }
    middle <- ""
    for (o in order) {
        middle <- paste(middle, let[o], sep = '')
    }
    q <- paste(start, middle, end, sep = '')
    return(q)
}

proc <-function(s) {
    cat( "Input:", s, "\n")
    words <- strsplit(s, " ")[[1]]
    new <- ""
    for (o in words) {
        new <- paste(new, jumble(o), sep = ' ')
    }
    cat( "Output:", new, "\n")
}

s <- "This supposed Cambridge research is unfortunately an urban legend"
proc(s)
