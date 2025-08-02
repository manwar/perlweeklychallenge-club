proc <- function(int) {
    print(paste("Input:", int))
    num <- -1
    curr <- 0
    prev <- 0
    cnt <- 0
    L <- strsplit(int, "")
    Q <- L[[1]]
    for (i in 1:nchar(int)) {
        prev <- curr
        curr <- Q[i]
        if (prev == curr) {
            cnt <- cnt + 1
        } else {
            if (cnt == 2) {
                num <- prev
                break;
            } else {
                cnt <- 0
            }
        }
    }
    print(paste("Output", num))
}
proc("123444567")
proc("1233334")
proc("10020003")
