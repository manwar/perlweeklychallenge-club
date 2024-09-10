proc <-function(ints) {
    cat("Input: ints =", ints, "\n")
    while (length(ints) > 2) {
	L <- c()
	for (i in 1:as.integer((length(ints))/2)) {
	    if (i %% 2 != 0) {
		L <- append(L, min(ints[2*i - 1], ints[2*i]))
	    } else {
		L <- append(L, max(ints[2*i-1], ints[2*i]))
	    }
	}
	ints <- L
    }
    cat("Output:", min(ints), "\n")
}
ints <- c(2, 1, 4, 5, 6, 3, 0, 2)
proc(ints)
ints <- c(0, 5, 3, 2)
proc(ints)
ints <- c(9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)
proc(ints)
