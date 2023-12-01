ch_1 <- function(){
    structure(list(), class = "ch_1")
}

count_smaller <- function(self, l){
    UseMethod("count_smaller", self)
}

count_smaller.ch_1 <- function(self, integers) {
    r <- c()
    for (i in 1:(length(integers))) {
        x <- integers[i]
        r[length(r) + 1] <- length(which(integers < x))
    }
    return(r)
}

ch_1 <- ch_1()
print(count_smaller(ch_1, c(8, 1, 2, 2, 3)))
print(count_smaller(ch_1, c(6, 5, 4, 8)))
print(count_smaller(ch_1, c(2, 2, 2)))