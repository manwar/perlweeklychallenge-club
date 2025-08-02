proc <- function(str) {
    print(paste("Input:", str))
    Let <- strsplit(str, "")
    let <- Let[[1]]
    prev <- "0"
    curr <- ""
    cnt <- -1
    for (i in 1: nchar(str)) {
        curr = let[i]
        if (tolower(prev) != tolower(curr)) {
            cnt <- cnt + 1
        }
        prev <- curr
    }
    print(paste("Output:", cnt))
}
proc("pPeERrLl")
proc("rRr")
proc("GoO")
