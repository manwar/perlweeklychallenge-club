# Task 2: Reshape Matrix
# Submitted by: Mohammad S Anwar
# 
# You are given a matrix (m x n) and two integers (r) and (c).
# Write a script to reshape the given matrix in form (r x c) with the original value in the given matrix. If you can’t reshape print 0.
# 
# Example 1
# Input: [ 1 2 ]
#        [ 3 4 ]
#        $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
#        $r = 1
#        $c = 4
#
# Output: [ 1 2 3 4 ]
# 
# Example 2
# Input: [ 1 2 3 ]
#        [ 4 5 6 ]
# 
#        $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
#        $r = 3
#        $c = 2
# 
# Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]
#         [ 1 2 ]
#         [ 3 4 ]
#         [ 5 6 ]
# 
# Example 3
# Input: [ 1 2 ]
#        $matrix = [ [ 1, 2 ] ]
#        $r = 3
#        $c = 2
# 
# Output: 0

weak_reshape <- function(m, r, c) {
    cat('\nInput matrix: ')
    print(m)
    if (r*c == nrow(m)*ncol(m)) {
        m <- t(m)
        m <- matrix(m, nrow = c, ncol = r, byrow = FALSE)
        m <- t(m)
        cat(m)
    } else {
        print(0)
    }
    cat('\n')
}

m <- matrix( c(1, 2, 3, 4),
             nrow=2, ncol=2, byrow=TRUE)
weak_reshape(m, 1, 4)

m <- matrix( c(1, 2, 3, 4, 5, 6),
             nrow=2, ncol=3, byrow=TRUE)
weak_reshape(m, 3, 2)

m <- matrix( c(1, 2),
             nrow=1, ncol=2, byrow=TRUE)
weak_reshape(m, 3, 2)
