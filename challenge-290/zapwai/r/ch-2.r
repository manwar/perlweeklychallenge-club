proc <-function(s) {
    cat("Input:", s, "\n")
    s <- gsub(" ", "", s)
    digit <- strsplit(s, "")[[1]]
    digit <- as.integer(digit)
    payload <- digit[length(digit)]
    digit <- digit[-length(digit)]
    digit <- rev(digit)
    sum <- 0
    for (i in 1:length(digit)) {
	if (i %% 2 != 0) {
	    x <- 2*digit[i]
	    if (x > 9) {
		a <- x %/% 10
		b <- x %% 10
                sum <- sum + a + b
            } else {
                sum <- sum + x
            }
        } else {
            sum <- sum + digit[i]
        }
    }
    ans <- "false"
    if ((sum + payload) %% 10 == 0) {
        ans <- "true"
    }
    cat( "Output:", ans, "\n")
}

s <- "17893729974"
proc(s)
s <- "4137 8947 1175 5904"
proc(s)
s <- "4137 8974 1175 5904"
proc(s)
