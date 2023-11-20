ch_1 <- function(){
    structure(list(), class = "ch_1")
}

reverse_pairs <- function(self, l){
    UseMethod("reverse_pairs", self)
}

reverse_pairs.ch_1 <- function(self, integers) {
    r <- list()
    for (i in 1:(length(integers) - 1)) {
        for (j in (i + 1):length(integers)) {
            if (integers[i] > integers[j] + integers[j]) {
                r <- c(r, list(c(i, j)))
            }
        }
    }
    return(length(r))
}

ch_1 <- ch_1()
number_reverse_pairs <- reverse_pairs(ch_1, c(1, 3, 2, 3, 1))
print(number_reverse_pairs)
number_reverse_pairs <- reverse_pairs(ch_1, c(2, 4, 3, 5, 1))
print(number_reverse_pairs)