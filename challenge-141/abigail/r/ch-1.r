#
# See ../README.md
#

#
# Run as: Rscript ch-1.r 
#

count         <- 10
nr_of_divisor <-  8

n <- 0
while (count > 0) {
    n <- n + 1
    s <- floor (sqrt (n))
    if (n == s * s) {
        next
    }
    c <- 0
    for (d in 1 : s) {
        if (n %% d == 0) {
            c <- c + 2
            if (c > nr_of_divisor) {
                break
            }
        }
    }
    if (c == nr_of_divisor) {
        cat (n, "\n")
        count <- count - 1
    }
}
