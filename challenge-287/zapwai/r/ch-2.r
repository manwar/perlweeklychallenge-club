proc <-function(str) {
    cat("Input:", str, "\n")
    output <- "False"
    p <- strsplit(str, "\\.")[[1]]
    if (length(p) == 1) {
	if (grepl('^\\d+$',str)) {
	    output <- "True"
	} else if (grepl('^\\d+e\\d+$|\\d+E\\d+$', str)) {
	    output <- "True"
	}
    } else if (length(p) == 2) {
	if (grepl('^\\d+$', p[1]) && grepl('^\\d+$', p[2])) {
	    output <- "True"
	} else if (grepl('^\\d+$', p[1]) && grepl('^\\d+e\\d+$|\\d+E\\d+$', p[2])) {
	    output <- "True"
	}
    }
    cat("Output:", output, "\n")
}
str <- "1"
proc(str)
str <- "56e10"
proc(str)
str <- "2E32"
proc(str)
str <- "a"
proc(str)
str <- "1.2"
proc(str)
str <- "1.2.6"
proc(str)
str <- "3.142e10"
proc(str)
str <- "3.142e42B"
proc(str)
