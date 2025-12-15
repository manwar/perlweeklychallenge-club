
## arrWords = ["cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"]  ## Example 1
## arrWords = ["hello", "hell", "world", "wor", "ellow", "elloworld"]  ## Example 2
## arrWords = ["a", "aa", "aaa", "aaaa"]  ## Example 3
## arrWords = ["flower", "flow", "flight", "fl", "fli", "ig", "ght"]  ## Example 4
arrWords = ["car", "carpet", "carpenter", "pet", "enter", "pen", "pent"]  ## Example 5

arrOutput = []
for nIndx, strCheck in enumerate(arrWords):
    arrTemp = [strTempCheck for nSubIndx, strTempCheck in enumerate(arrWords) if nIndx != nSubIndx and strCheck in strTempCheck]

    if len(arrTemp) == 0:
        continue

    arrOutput.append(strCheck)

print (arrOutput)
