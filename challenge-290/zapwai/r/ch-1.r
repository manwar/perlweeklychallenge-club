proc <-function(ints) {
    cat("Input: ints = ", ints, "\n");
    ans <- "false"
    for (i in 1:(length(ints)-1)) {
	for (j in (i + 1) : length(ints)) {
            if (ints[i] == 2 * ints[j] || ints[j] == 2 * ints[i]) {
                ans <- "true"
            }
	}
    }
    cat("Output:", ans, "\n")
}

ints <- c(6, 2, 3, 3)
proc(ints)
ints <- c(3, 1, 4, 13)
proc(ints)
ints <- c(2, 1, 4, 2)
proc(ints)
