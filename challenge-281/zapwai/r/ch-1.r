proc <- function(coord) {
    cat("Input:", coord, "\n")
    L <- strsplit(coord, "")
    l <- L[[1]][1]
    n <- as.integer(L[[1]][2])
    l <- tolower(l)
    if (l == "a" || l == "c" || l == "e" || l == "g") {
        if (n %% 2 == 0) {
            cat( "Output: True\n" )
        } else {
            cat( "Output: False\n" )
        }
    } else {
        if (n %% 2 == 1) {
            cat( "Output: True\n" )
        } else {
            cat( "Output: False\n" )
        }
    }
}
coord <- "d3"
proc(coord)
coord <- "g5"
proc(coord)
coord <- "e6"
proc(coord)