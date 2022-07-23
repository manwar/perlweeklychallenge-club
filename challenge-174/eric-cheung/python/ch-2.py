
## Remark
## https://www.geeksforgeeks.org/permutation-and-combination-in-python/


## A Python program to print all permutations using library function
from itertools import permutations


def getPermuArr(arrList):

    return permutations(arrList)


def permutation2rank(arrList, arrCheck):

    arrPerm = getPermuArr(arrList)
    return list(arrPerm).index(tuple(arrCheck))


def rank2permutation(arrList, nIndex):

    arrPerm = getPermuArr(arrList)
    return list(list(arrPerm)[nIndex])


arrInput = [0, 1, 2]
arrFind = [1, 0, 2]

print (permutation2rank(arrInput, arrFind))
print (rank2permutation(arrInput, 1))

