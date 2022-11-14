
## Credit:
## https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-190/roger-bell-west/python/ch-2.py

from collections import deque

def GetMap(strFuncInput):
    return chr(int(strFuncInput) + 64)

def GetStack(stackLeft, stackLeftTail, nLastPos):

    stackCopy = stackLeft.copy()
    stackCopy.append(stackLeftTail[0:nLastPos])
    stackCopy.append(stackLeftTail[nLastPos:])

    return stackCopy

def decodedList(strFuncInput):
    stackTemp = deque()
    stackTemp.append([strFuncInput])
    arrTempOutput = set()

    while len(stackTemp) > 0:

        stackTempPopLeft = stackTemp.popleft()
        stackTempPopLeftTail = stackTempPopLeft.pop()

        if len(stackTempPopLeftTail) == 0:
            arrTempOutput.add(tuple(stackTempPopLeft))
            continue

        if stackTempPopLeftTail[0] != "0":
            stackTemp.append(GetStack(stackTempPopLeft, stackTempPopLeftTail, 1))

        if len(stackTempPopLeftTail) >= 2:
            nCheckVal = int(stackTempPopLeftTail[0:2])
            if nCheckVal >= 1 and nCheckVal <= 26:
                stackTemp.append(GetStack(stackTempPopLeft, stackTempPopLeftTail, 2))

    arrOuput = []

    for elemLoop in arrTempOutput:
        arrOuput.append("".join(GetMap(charLoop) for charLoop in elemLoop))

    arrOuput.sort()

    return arrOuput


## strInput = "11"  ## Example 1
## strInput = "1115"  ## Example 2
strInput = "127"  ## Example 3

print (decodedList(strInput))
