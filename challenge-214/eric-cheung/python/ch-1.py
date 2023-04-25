
arrInputScore = [1, 2, 4, 3, 5]  ## Example 1
## arrInputScore = [8, 5, 6, 7, 4]  ## Example 2
## arrInputScore = [3, 5, 4, 2]  ## Example 3
## arrInputScore = [2, 5, 2, 1, 7, 5, 1]  ## Example 4

arrUniqSortScore = list(set(arrInputScore))
arrUniqSortScore = arrUniqSortScore[::-1]
arrInterRank = [max(arrUniqSortScore.index(nElem), len([1 for nLoop in arrInputScore if nLoop > nElem])) for nElem in arrInputScore]
arrOutputRank = ["G" if nElem == 0 else "S" if nElem == 1 else "B" if nElem == 2 else nElem + 1 for nElem in arrInterRank]

print (arrOutputRank)
