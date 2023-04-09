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

def check_toeplitz(m)
    rc = [m.length, m[0].length].min - 1
    val = m[0][0]
    (0..rc).each {|e|
        return 'false' if m[e][e] != val
    }
    return 'true'
end

matrix = [ [4, 3, 2, 1],
            [5, 4, 3, 2],
            [6, 5, 4, 3],
          ]
puts check_toeplitz matrix

matrix = [ [1, 2, 3],
           [3, 2, 1],
         ]
puts check_toeplitz matrix
