proc <- function(start, end) {
    cat( "Input:", start, end, "\n" )
    mylist <- list(moves(start))
    round <- 0
    found <- 0
    while (found == 0) {
        if (round > length(mylist)) break
	round <- round + 1
	for (old_move in mylist[[round]]) {
	   if (old_move == end) {
		found <- 1
                break
	   }
	}
        L <- c()
        for (old_move in mylist[[round]]) {
            L <- append(L, moves(old_move))
        }
        L <- unique(L)
        mylist <- append(mylist, list(L))
    }
    cat( "Output:", round, "\n" )
}

moves <- function(coord) {
    L <- strsplit(coord, "")
    l <- L[[1]][1]
    row = as.integer(L[[1]][2])
    cols <- "abcdefgh"
    colchar <- strsplit(cols, "")[[1]]
    col <- which(colchar == l)
    r <- c()
    c <- c()
    for (i in c(-2, 2)) {
	for (j in c(-1, 1)) {
	   c <- append(c, col + i)
	   r <- append(r, row + j)
	}
    }
    for (i in c(-1, 1)) {
	for (j in c(-2, 2)) {
	   c <- append(c, col + i)
	   r <- append(r, row + j)
	}
    }
    list <- c()
    for (i in 1:8) {
	if (c[i] < 1 || c[i] > 8) {
            next
        }
	if (r[i] < 1 || r[i] > 8) {
            next
        }
	move <- paste0(colchar[c[i]], r[i])
	list <- append(list, move)
    }
    return(list)
}

start = "g2"
end = "a8"
proc(start, end)

start = "g2"
end = "h2"
proc(start, end)