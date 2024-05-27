
## arrInt = [0, 1, 2, 3, 4, 5, 6, 7, 8]  ## Example 1
arrInt = [1024, 512, 256, 128, 64]  ## Example 2

arrOrder = [[bin(nElem).replace("0b", "").count("1"), nElem] for nElem in arrInt]

arrOutput = [nElem for strSort, nElem in sorted(arrOrder, key = lambda nElem: (nElem[0], nElem[1]))]

print (arrOutput)
