
import numpy as np

## arrGrid = [[0, 1, 1], [0, 0, 1], [0, 0, 0]]  ## Example 1
## arrGrid = [[0, 1, 0, 0], [0, 0, 0, 0], [1, 1, 0, 0], [1, 1, 1, 0]]  ## Example 2
## arrGrid = [[0, 1, 0, 1], [0, 0, 1, 1], [1, 0, 0, 0], [0, 0, 1, 0]]  ## Example 3
## arrGrid = [[0, 1, 1], [0, 0, 0], [0, 1, 0]]  ## Example 4
arrGrid = [[0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 1, 0, 1, 1], [1, 1, 0, 0, 0], [1, 1, 0, 1, 0]]  ## Example 5

arrWins = [sum(arrLoop) for arrLoop in arrGrid]

print (np.argmax(arrWins))
