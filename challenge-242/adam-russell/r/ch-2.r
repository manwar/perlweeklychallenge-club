ch_2 <- function() {
    structure(list(), class = "ch_2")
}

flip_matrix <- function (self, m) {
    UseMethod("flip_matrix", self)
}

flip_matrix.ch_2 <- 
    function (self, m) {
        r <- t(apply(m, 1, function(row){
               row<-rev(row)
               sapply(row, function (x) {
               as.integer(!x & 1)
             })
        }))
        return(r)
}

ch_2 <- ch_2()
matrix_data <- matrix(c(1, 1, 0, 1, 0, 1, 0, 0, 0), nrow = 3, byrow = TRUE)
print(matrix_data)
flipped_matrix <- flip_matrix(ch_2, matrix_data)
print(flipped_matrix)
matrix_data <- matrix(c(1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0), nrow = 4, byrow = TRUE)
print(matrix_data)
flipped_matrix <- flip_matrix(ch_2, matrix_data)
print(flipped_matrix)
