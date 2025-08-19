
## arrWords = ["bella", "label", "roller"]  ## Example 1
## arrWords = ["cool", "lock", "cook"]  ## Example 2
## arrWords = ["hello", "world", "pole"]  ## Example 3
## arrWords = ["abc", "def", "ghi"]  ## Example 4
arrWords = ["aab", "aac", "aaa"]  ## Example 5

arrOutput = []

for charLoop in set(arrWords[0]):
    bFound = True

    for strLoop in arrWords[1:]:
        if charLoop not in strLoop:
            bFound = False
            break

    if not bFound:
        continue

    nCount = min([strLoop.count(charLoop) for strLoop in arrWords])

    arrOutput = arrOutput + list(charLoop * nCount)

print (arrOutput)
