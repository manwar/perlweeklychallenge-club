
nArrList = [1, 1, 2, 6, 2]  ## Example 1
## nArrList = [1, 3, 5, 7]  ## Example 2
## nArrList = [6, 4, 4, 6, 1]  ## Example 3

nArrEvenList = [nLoop for nLoop in nArrList if nLoop % 2 == 0]
nArrUniqEvenList = list(set(nArrEvenList))

nSmallEvenNum = -1
nEvenNumCount = 0

for nLoop in nArrUniqEvenList:

    nCount = nArrEvenList.count(nLoop)

    if nCount > nEvenNumCount and (nLoop < nSmallEvenNum or nSmallEvenNum < 0):
        nSmallEvenNum = nLoop
        nEvenNumCount = nCount

print (nSmallEvenNum)
