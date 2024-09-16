proc<-function(str) {
    cat("Input:", str,"\n")
    len <- nchar(str)
    len_diff <- 0
    if (len < 6) {
	len_diff <- 6 - len
    } else if (len > 20) {
	len_diff <- len - 20
    }
    l <- strsplit(str, "")[[1]]
    lengths = c()
    hits <- 0
    if (len > 1) {
        for (i in 1:(len-1)) {
            if (l[i] == l[i+1]) {
                hits <- hits + 1
            } else {
                if (hits > 1) {
                    lengths <- append(lengths, 1+hits)
                }
                hits <- 0
            }
        }
        if (hits > 1) {
            lengths <- append(lengths, 1+hits)
        }
    }
    steps <- 0
    for (l in lengths) {
	steps <- steps + floor(l/3)
    }
    lflag <- 1
    uflag <- 1
    dflag <- 1
    if (grepl('[a-z]', str)) {
        lflag <- 0
    }
    if (grepl('[A-Z]', str)) {
        uflag <- 0
    }
    if (grepl('\\d', str)) {
        dflag <- 0
    }
    tally <- lflag + uflag + dflag
    out_val <- len_diff + steps
    if (out_val < tally) {
	out_val <- out_val + tally - out_val
    }
    cat( "Output: ", out_val, "\n")
}

str <- "a"
proc(str)
str <- "aB2"
proc(str)
str <- "PaaSW0rd"
proc(str)
str <- "turbbbbotttt"
proc(str)
str  <- "111"
proc(str)
