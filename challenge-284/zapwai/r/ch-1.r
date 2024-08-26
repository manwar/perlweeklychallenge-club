proc <- function(ints) {
    cat("Input: ints = ")
    cat(ints)
    lucky = -1
    freq = c(0)
    for (i in 1:max(ints)) {
        freq <- append(freq, 0)
    }
    for (item in ints) {
	freq[item] <- freq[item] + 1
    }
    for (i in 1:length(freq)) {
	if (i == freq[i]) {
	    lucky <- i
	}
    }
    cat("\nOutput:", lucky, "\n")
}
ints = c(2, 2, 3, 4)
proc(ints)
ints = c(1, 2, 2, 3, 3, 3)
proc(ints)
ints = c(1, 1, 1, 3)
proc(ints)
