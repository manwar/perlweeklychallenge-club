
## arrInt = [1, 2, 2, 4, 1, 5]  ## Example 1
arrInt = [1, 2, 3, 4, 5]  ## Example 2

arrFreq = [arrInt.count(nLoop) for nLoop in set(arrInt)]

nMaxFreq = max(arrFreq)

print (nMaxFreq * arrFreq.count(nMaxFreq))
