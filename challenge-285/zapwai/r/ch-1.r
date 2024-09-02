proc <- function(routes) {
    cat("Input: ")
    for (j in routes) {
        cat(j,", ")
    }
    cat("\n");
    inlist <- c()
    out <- c()
    for (r in routes) {
	inlist <- c(inlist, r[1])
	out <- c(out, r[2])
    }
    ans <- "a"
    for (needle in out) {
	found <- 0
	for (hay in inlist) {
	    if (needle == hay) {
		found <- 1
                break
	    }
	}
	if (found == 0) {
	    ans <- needle
	}
    }
    cat("Output:", ans,"\n")
}

routes = list(c("B","C"), c("D","B"), c("C","A"))
proc(routes)
routes = list(c("A","Z"))
proc(routes)
