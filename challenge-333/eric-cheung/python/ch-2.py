
## arrInt = [1, 0, 2, 3, 0, 4, 5, 0]  ## Example 1
## arrInt = [1, 2, 3]  ## Example 2
## arrInt = [1, 2, 3, 0]  ## Example 3
## arrInt = [0, 0, 1, 2]  ## Example 4
arrInt = [1, 2, 0, 3, 4]  ## Example 5

arrOut = arrInt[:]

arrZeroPos = [nPos for nPos, nElem in enumerate(arrInt) if nElem == 0]

if len(arrZeroPos) == 0:
    print (arrOut)
else:
    for nPos in arrZeroPos[::-1]:
        arrOut.insert(nPos, 0)
    print (arrOut[:len(arrInt)])
