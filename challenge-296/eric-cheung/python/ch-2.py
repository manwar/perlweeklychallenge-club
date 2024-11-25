
## Ref.
## https://github.com/zqfang/LeetCode/blob/master/Python/matchsticks-to-square.py
## https://juejin.cn/post/7128190968976670757

nLen = 0
nSumDiv = 0
arrSort = []

def GetFunc(nPoint_01, nPoint_02, nPoint_03, nPoint_04, nIndx):

    global nLen, nSumDiv
    global arrSort

    if nPoint_01 == nPoint_02 == nPoint_03 == nPoint_04 == nSumDiv:
        return True

    if nPoint_01 > nSumDiv or nPoint_02 > nSumDiv or nPoint_03 > nSumDiv or nPoint_04 > nSumDiv or nIndx > nLen - 1:
        return False

    return GetFunc(nPoint_01 + arrSort[nIndx], nPoint_02, nPoint_03, nPoint_04, nIndx + 1) or GetFunc(nPoint_01, nPoint_02 + arrSort[nIndx], nPoint_03, nPoint_04, nIndx + 1) or GetFunc(nPoint_01, nPoint_02, nPoint_03 + arrSort[nIndx], nPoint_04, nIndx + 1) or GetFunc(nPoint_01, nPoint_02, nPoint_03, nPoint_04 + arrSort[nIndx], nIndx + 1)

def GetMakeSqr(arrMatchSticks):

    global nLen, nSumDiv
    global arrSort

    nLen = len(arrMatchSticks)
    nMatchTotal = sum(arrMatchSticks)

    arrMatchSticks.sort(reverse = True)
    arrSort = arrMatchSticks

    if nMatchTotal % 4 > 0:
        return False

    nSumDiv = int(nMatchTotal / 4)

    return GetFunc(0, 0, 0, 0, 0)

## arrInts = [1, 2, 2, 2, 1]  ## Example 1
## arrInts = [2, 2, 2, 4]  ## Example 2
## arrInts = [2, 2, 2, 2, 4]  ## Example 3
arrInts = [3, 4, 1, 4, 3, 1]  ## Example 4

print (GetMakeSqr(arrInts))
