
## arrNum = [2, 4, 3, 3, 3, 4, 5, 4, 2]  ## Example 1
## arrNum = [1, 2, 2, 2, 2, 1]  ## Example 2
## arrNum = [1]  ## Example 3
arrNum = [2, 2, 2, 1, 1, 2, 2, 2]  ## Example 4

arrUniq = list(set(arrNum))
arrCount = [arrNum.count(nElem) for nElem in arrUniq]
arrSQ = [nElem * nElem for nElem in arrCount] 

print (sum(arrSQ))
