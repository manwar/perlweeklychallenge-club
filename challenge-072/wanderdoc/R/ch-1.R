trailingZeroes <- function(x) nchar(regmatches(x, regexpr("[^0]\\K[0]+$", x, perl=TRUE)))
result <- as.integer(sapply(factorial(1:10), trailingZeroes))
result[is.na(result)] <- 0

result
rm(trailingZeroes, result)
