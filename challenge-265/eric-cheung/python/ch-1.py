
arrInt = [1, 2, 3, 3, 3, 3, 4, 2]  ## Example 1
## arrInt = [1, 1]  ## Example 2
## arrInt = [1, 2, 3]  ## Example 3

arrOutput = [nElem for nElem in set(arrInt) if arrInt.count(nElem) > len(arrInt) * 0.33]

print ("undef" if len(arrOutput) == 0 else min(arrOutput))
