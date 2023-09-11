
## arrWordList = ["aba", "aabb", "abcd", "bac", "aabc"]  ## Example 1
## arrWordList = ["aabb", "ab", "ba"]  ## Example 2
arrWordList = ["nba", "cba", "dba"]  ## Example 3

arrCharList = ["".join(sorted(list(set([*strWordLoop])))) for strWordLoop in arrWordList]

arrOutputList = [1 for nRowLoop in range(0, len(arrCharList) - 1) for nColLoop in range(nRowLoop + 1, len(arrCharList)) if arrCharList[nRowLoop] == arrCharList[nColLoop]]

print (len(arrOutputList))
