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

import numpy as np

def weak_reshape(m,r,c):
    m = np.array(m)
    print('Input matrix: ')
    print(m)
    print("reshaping {:d}x{:d}: ".format(r, c))
    curr_r, curr_c = m.shape
    if (curr_r*curr_c == r*c):
        print(m.reshape(r, c))
    else:
        print(0)
    print()

weak_reshape([ [ 1, 2 ], [ 3, 4 ] ], 1, 4);
weak_reshape([ [ 1, 2, 3 ] , [ 4, 5, 6 ] ], 3, 2);
weak_reshape([ [ 1, 2 ] ], 3, 2);
