
from itertools import combinations

def HammingDist (nInput_01, nInput_02):
    strInput_01 = "{0:b}".format(nInput_01)
    strInput_02 = "{0:b}".format(nInput_02)

    return abs(len(strInput_01) - len(strInput_02)) + sum([1 if strInput_01[len(strInput_01) - nIndx - 1] != strInput_02[len(strInput_02) - nIndx - 1] else 0 for nIndx in range(min(len(strInput_01), len(strInput_02)))])


## arrInt = [4, 14, 2]  ## Example 1
arrInt = [4, 14, 4]  ## Example 2


objComb = combinations(arrInt, 2)

arrOutput = [HammingDist(arrLoop[0], arrLoop[1]) for arrLoop in list(objComb)]

print (sum(arrOutput))
