
## arrInt = [1, 2, 2, 1, 1, 3]  ## Example 1
## arrInt = [1, 2, 3]  ## Example 2
arrInt = [-2, 0, 1, -2, 1, 1, 0, 1, -2, 9]  ## Example 3

arrCount = [arrInt.count(elemLoop) for elemLoop in set(arrInt)]

## print (arrCount)

print (1 if len(arrCount) == len(set(arrCount)) else 0)
