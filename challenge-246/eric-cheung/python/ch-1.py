
from random import randint

nMaxNum = 49
nNumChosen = 6

arrInput = list(range(1, nMaxNum + 1))
arrOuput = []

for nLoop in range(nNumChosen):
    nIndx = randint(0, nMaxNum - nLoop)
    arrOuput.append(arrInput[nIndx])
    del arrInput[nIndx]

arrOuput.sort()

print (arrOuput)
