
arrWords = ["java", "javascript", "julia"]  ## Example 1
## arrWords = ["bella", "label", "roller"]  ## Example 2
## arrWords = ["cool", "lock", "cook"]  ## Example 3

arrUniqChar = list(set([*arrWords[0]]))
arrOutput = []

for charLoop in arrUniqChar:
    bExist = True
    nNumCount = arrWords[0].count(charLoop)

    for wordLoop in arrWords[1:]:
        if charLoop in wordLoop:
            nNumCount = min(nNumCount, wordLoop.count(charLoop))
        else:
            bExist = False
            break

    if bExist:
        arrOutput = arrOutput + [charLoop] * nNumCount

print (arrOutput)
