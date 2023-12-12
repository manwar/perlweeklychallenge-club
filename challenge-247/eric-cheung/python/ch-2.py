
## strInput = "abcdbca"  ## Example 1
strInput = "cdeabeabfcdfabgcd"  ## Example 2

arrPairStr = [strInput[nIndxLoop : nIndxLoop + 2] for nIndxLoop in range(len(strInput) - 1)]

arrUniqPair = list(set(arrPairStr))
arrCountPair = [arrPairStr.count(strLoop) for strLoop in arrUniqPair]

arrMaxPair = sorted([arrUniqPair[nIndx] for nIndx in range(len(arrCountPair)) if arrCountPair[nIndx] == max(arrCountPair)])

print (arrMaxPair[0])
