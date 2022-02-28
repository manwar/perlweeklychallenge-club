left_fact <- 1
fact <- 1

for (i in 1:10) {
    cat(left_fact, '')
    fact <- fact * i
    left_fact <- left_fact + fact
}
cat("\n")
