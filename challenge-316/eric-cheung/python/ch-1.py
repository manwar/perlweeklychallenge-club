
## arrList = ["perl", "loves", "scala"]  ## Example 1
## arrList = ["love", "the", "programming"]  ## Example 2
arrList = ["java", "awk", "kotlin", "node.js"]  ## Example 3

bIsCircular = True
for nIndx, strWord in enumerate(arrList):
    if nIndx == 0:
        continue

    if strWord[0] != arrList[nIndx - 1][-1]:
        bIsCircular = False
        break

print (bIsCircular)
