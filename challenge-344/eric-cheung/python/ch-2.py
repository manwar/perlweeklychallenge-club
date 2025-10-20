
from itertools import permutations

## Example 1
## arrSource = [[2, 3], [1], [4]]
## arrTarget = [1, 2, 3, 4]

## Example 2
## arrSource = [[1, 3], [2, 4]]
## arrTarget = [1, 2, 3, 4]

## Example 3
## arrSource = [[9, 1], [5, 8], [2]]
## arrTarget = [5, 8, 2, 9, 1]

## Example 4
## arrSource = [[1], [3]]
## arrTarget = [1, 2, 3]

## Example 5
arrSource = [[7, 4, 6]]
arrTarget = [7, 4, 6]

strTarget = "".join(map(str, arrTarget))
arrPerm = permutations(arrSource)

bIsFound = False
for arrLoop in arrPerm:
    strTemp = "".join(["".join(map(str, arrSubLoop)) for arrSubLoop in arrLoop])
    if strTarget == strTemp:
        bIsFound = True
        break

print (bIsFound)
