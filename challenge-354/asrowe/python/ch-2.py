'''
You are given m x n matrix and an integer, $k > 0.

Write a script to shift the given matrix $k times.

Each shift follow the rules:

Rule 1:
Element at grid[i][j] moves to grid[i][j + 1]
This means every element moves one step to the right within its row.

Rule 2:
Element at grid[i][n - 1] moves to grid[i + 1][0]
This handles the last column: elements in the last column of row i wrap to the first column of the next row (i+1).

Rule 3:
Element at grid[m - 1][n - 1] moves to grid[0][0]
This is the bottom-right corner: it wraps to the top-left corner.

Input: @matrix = ([1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9],)
       $k = 1
Output: ([9, 1, 2],
         [3, 4, 5],
         [6, 7, 8],)


Input: @matrix = ([10, 20],
                  [30, 40],)
       $k = 1
Output: ([40, 10],
         [20, 30],)


Input: @matrix = ([1, 2],
                  [3, 4],
                  [5, 6],)
      $k = 1
Output: ([6, 1],
         [2, 3],
         [4, 5],)


Input: @matrix = ([1, 2, 3],
                  [4, 5, 6],)
       $k = 5
Output: ([2, 3, 4],
         [5, 6, 1],)


Input: @matrix = ([1, 2, 3, 4])
       $k = 1
Output: ([4, 1, 2, 3])

'''

import unittest
from collections import deque

e1_i = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
e1_k = 1
e1_o = [[9, 1, 2],[3, 4, 5],[6, 7, 8]]

e2_i = [[10, 20],[30, 40]]
e2_k = 1
e2_o = [[40, 10],[20, 30]]

e3_i = [[1, 2],[3, 4],[5, 6]]
e3_k = 1
e3_o = [[6, 1],[2, 3],[4, 5]]

e4_i = [[1, 2, 3],[4, 5, 6]]
e4_k = 5
e4_o = [[2, 3, 4],[5, 6, 1]]


e5_i = [[1, 2, 3, 4]]
e5_k = 1
e5_o = [[4, 1, 2, 3]]

def matRotate(m, k):
    #1 Save width
    mat_width = len(m[0])
    
    #2 Flatten
    mat_1d = deque([x for xs in m for x in xs])
    
    #3 Rotate
    mat_1d.rotate(k) # all of this was just because I wanted to use a rotate function.
    
    #4 Rechunk
    mat_1d = list(mat_1d)
    nrows = len(mat_1d)//mat_width  # note // is in integer division
    
    out = [mat_1d[i*mat_width:i*mat_width+mat_width] for i in range(nrows)]

    return out

class ChallengeRunner(unittest.TestCase):
    def test_ex1(self):
        self.assertEqual(matRotate(e1_i,e1_k),e1_o)

    def test_ex2(self):
        self.assertEqual(matRotate(e2_i,e2_k),e2_o)

    def test_ex3(self):
        self.assertEqual(matRotate(e3_i,e3_k),e3_o)

    def test_ex4(self):
        self.assertEqual(matRotate(e4_i,e4_k),e4_o)

    def test_ex5(self):
        self.assertEqual(matRotate(e5_i,e5_k),e5_o)


if __name__ == '__main__':
    unittest.main()