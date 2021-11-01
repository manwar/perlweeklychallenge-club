#
# See ../README.md
#

#
# Run as: Rscript ch-2.r < input-file
#

count <- function (target, this_fib = 1, prev_fib = 1) {
    if (target <  this_fib) {
        0
    } else if (target == this_fib) {
        1
    } else {
        count (target - this_fib, this_fib + prev_fib, this_fib) +
        count (target,            this_fib + prev_fib, this_fib)
    }
}
    
    

stdin <- file ('stdin', 'r')
repeat {
    n <- readLines (stdin, n = 1)
    if (length (n) == 0) {
        break
    }
    cat (count (as.integer (n)), "\n")
}
