
## arrWordInput = ['abc', 'xyz', 'tsu']  ## Example 1
## arrWordInput = ['rat', 'cab', 'dad']  ## Example 2
arrWordInput = ['x', 'y', 'z']  ## Example 3

arrRemovedWord = []

for strWordLoop in arrWordInput:

    strSortWordLoop = ''.join(sorted(strWordLoop))
    if strWordLoop == strSortWordLoop:
        continue

    arrRemovedWord.append(strWordLoop)

print (len(arrRemovedWord))
