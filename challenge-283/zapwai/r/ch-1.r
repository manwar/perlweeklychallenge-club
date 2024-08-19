proc <- function(ints) {
    cat("Input: ints = ") 
    cat(ints)
    num <- 0
    for (i in 1: length(ints)) {
	found <- 0
	elem <- ints[i]
	for (j in 1:length(ints)) {
	    if (i == j) {
                next
            }
	    new_elem <- ints[j]
	    if (elem == new_elem) {
		found <- 1
	    }
	}
	if (found == 0) {
	    num <- elem
            break
	}
    }
    cat(paste("\nOutput:", num,"\n"))
}
ints <- c(3, 3, 1)
proc(ints)
ints <- c(3, 2, 4, 2, 4)
proc(ints)
ints <- c(1)
proc(ints)
