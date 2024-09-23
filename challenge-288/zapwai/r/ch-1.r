reverse <- function(s) {
    r <- strsplit(s, "")[[1]]
    q <- ""
    for (i in 1:nchar(s)) {
        q <- paste(q, r[nchar(s) - i + 1], sep = "")
    }
    return(q)
}

is_pal <-function(s) {
    r <- reverse(s)
    return (s == r)
}

proc <-function(s) {
    cat( "Input:", s, "\n")
    n <- as.numeric(s)
    found <- 0
    step <- 1
    while (found == 0) {
	m <- n - step
	if (is_pal(toString(m))) {
	    found <- 1
	    n <- m
	} else {
	    m <- n + step
	    if (is_pal(toString(m))) {
		found <- 1
		n <- m
	    }
	}
	step <- step + 1
    }
    cat( "Output:", n, "\n")
}

s <- "123"
proc(s)
s <- "2"
proc(s)
s <- "1400"
proc(s)
