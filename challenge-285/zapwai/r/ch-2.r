tally <- function(p, n, d, q, h) { return(p + 5*n + 10*d + 25*q + 50*h); }
amt <- 100
cnt <- 0
for (h in 0:as.integer(amt/50)) {
    for (q in 0:as.integer(amt/25)) {
	for (d in 0:as.integer(amt/10)) {
	    for (n in 0:as.integer(amt/5)) {
		for (p in 0:amt) {
		    if (tally(p, n, d, q, h) == amt) {
			cnt <- cnt + 1
		    }
		}
	    }
	}
    }
}
print(paste( "There are", cnt,"ways to make change for", amt,"cents"))


