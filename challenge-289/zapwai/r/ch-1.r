proc <-function(ints) {
    cat( "Input:", ints, "\n" )
    ans <- max(ints)
    new1 <- c()
    for (i in 1:length(ints)) {
	if (ints[i] != ans) {
	    new1 <- append(new1, ints[i])
	}
    }
    if (length(new1) > 0) {
	m2 <- max(new1)
	new2 <- c()
	for (i in 1:length(new1)) {
	    if (new1[i] != m2) {
		new2 <- append(new2, new1[i])
	    }
	}
	if (length(new2) > 0) {
	    ans <- max(new2)
	}
    }
    cat( "Output:", ans, "\n" )
}

ints <- c(5, 6, 4, 1)
proc(ints)
ints <- c(4, 5)
proc(ints)
ints <- c(1, 2, 2, 3)
proc(ints)
