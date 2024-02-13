
## arrWords = ["ab", "de", "ed", "bc"] ## Example 1
## arrWords = ["aa", "ba", "cd", "ed"] ## Example 2
arrWords = ["uv", "qp", "st", "vu", "mn", "pq"] ## Example 3

arrOutput = [arrWords[nRowLoop] for nRowLoop in range(len(arrWords) - 1) for nColLoop in range(nRowLoop + 1, len(arrWords)) if arrWords[nRowLoop] == arrWords[nColLoop][::-1]]

print (len(arrOutput))
