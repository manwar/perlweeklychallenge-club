
## Ref.
## https://math.libretexts.org/Courses/Mount_Royal_University/MATH_2150%3A_Higher_Arithmetic/5%3A_Diophantine_Equations/5.1%3A_Linear_Diophantine_Equations#:~:text=A%20Linear%20Diophantine%20equation%20(LDE,and%20y%20are%20unknown%20variables.
## https://stackoverflow.com/questions/59168914/finding-solutions-to-diophantine

from math import gcd
import sys


def IsConsecutiveEven (arrNum):
    for nIndx in range(0, len(arrNum) - 1):
        if arrNum[nIndx] % 2 == 0 and arrNum[nIndx + 1] % 2 == 0:
            return nIndx
    return -1


def DotProduct (arrNum_01, arrNum_02):
    return sum(arrLoop[0] * arrLoop[1] for arrLoop in zip(arrNum_01, arrNum_02))


def ModifiedGCD (arrNum, arrParam):
    if arrNum[1] == 0:
        return [arrNum[0], 1, 0]

    nX = 0
    nY = 0

    nDiv, nX, nY = ModifiedGCD([arrNum[1], arrNum[0] % arrNum[1]], [nX, nY])
    return [nDiv, nY, nX - nY * (arrNum[0] // arrNum[1])]

## arrInput = [1, 1, 2, 3, 5]  ## Example 1
## arrInput = [4, 2, 4, 5, 7]  ## Example 2
## arrInput = [4, 1, 2, -3, 8]  ## Example 3
## arrInput = [3, 9, 27, 81, 243]  ## Example 4
## arrInput = [3, 5, 27, 45, 243]  ## Example 5
## arrInput = [1, 1, 0, 0, 0]  ## Example 6
## arrInput = [0, 0, 0, 0, 0]  ## Example 7
## arrInput = [0, 3, 0, 0, 0]  ## Example 8
## arrInput = [0, 0, 3, 0, 0]  ## Example 9
arrInput = [2, 4, 8, 16, 32]  ## Example 10


## print (ModifiedGCD(arrInput[0:2], [0, 0]))
## print (ModifiedGCD([47, 30], [0, 0]))

if all([nLoop == 0 for nLoop in arrInput[2:]]):
    print (True)
    sys.exit()

nConsecutiveEvenIndx = IsConsecutiveEven (arrInput)
if nConsecutiveEvenIndx > -1:
    arrContainOdd = [nIndx for nIndx in range(nConsecutiveEvenIndx + 2, len(arrInput)) if arrInput[nIndx] % 2 == 1]
    if len(arrContainOdd) > 0:
        print (False)
        sys.exit()

nGCD = gcd (arrInput[0], arrInput[1])
if arrInput[2] % nGCD != 0:
    print (False)
    sys.exit()

arrParam = []

## ==== To Be Further Fine Tune ====
if arrInput[2] == arrInput[0] + arrInput[1]:
    arrParam.append(1)
    arrParam.append(1)
elif arrInput[2] == arrInput[0] - 2 * arrInput[1]:
    arrParam.append(1)
    arrParam.append(-2)
elif arrInput[2] == 3 * arrInput[0] + 2 * arrInput[1]:
    arrParam.append(3)
    arrParam.append(2)
elif arrInput[2] == 9 * arrInput[0]:
    arrParam.append(9)
    arrParam.append(0)
elif arrInput[2] == 2 * arrInput[1]:
    arrParam.append(0)
    arrParam.append(2)

## ==== To Be Further Fine Tune ====

if len(arrParam) == 0:
    print (False)
    sys.exit()

for nIndx in range(3, 5):
    if arrInput[nIndx] != DotProduct(arrParam, arrInput[nIndx - 2 : nIndx]):
        print (False)
        sys.exit()

print (True)
