proc <- function(ints) {
    cat("Input: ints = ")
    cat(ints)
    veracity <- "true"
    for (i in 1 : length(ints)) {
	freq <- ints[i]
	cnt <- 0
	for (elem in ints) {
	    if (elem == i-1) {
                cnt <- cnt + 1
            }
        }
        if (cnt != freq) {
            veracity = "false"
            break
        }
    }
    cat("\nOutput: ")
    cat(veracity, "\n")
}
ints = c(1, 2, 1, 0)
proc(ints)
ints = c(0, 3, 0)
proc(ints)
