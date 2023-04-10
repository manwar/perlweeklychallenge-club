# Task 1: Toeplitz Matrix
# Submitted by: Mohammad S Anwar
# 
# You are given a matrix m x n.
# Write a script to find out if the given matrix is Toeplitz Matrix.
# A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same elements.
# 
# 
# Example 1
# Input: @matrix = [ [4, 3, 2, 1],
#                    [5, 4, 3, 2],
#                    [6, 5, 4, 3],
#                  ]
# Output: true
# 
# Example 2
# Input: @matrix = [ [1, 2, 3],
#                    [3, 2, 1],
#                  ]
# Output: false

import numpy

def check_toeplitz(matrix):
    m = numpy.array(matrix)
    dim = min(m.shape)
    value = m[0][0]
    for i in range(dim):
        if m[i][i] != value:
            return 'false'
    return 'true'

if __name__ == "__main__":
    matrix = [ [4, 3, 2, 1],
               [5, 4, 3, 2],
               [6, 5, 4, 3],
             ]
    print(check_toeplitz(matrix))

    matrix = [ [1, 2, 3],
               [3, 2, 1],
             ]
    print(check_toeplitz(matrix))
