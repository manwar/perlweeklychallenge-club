
## arrWords = ["a", "ab", "abc", "d", "de", "def"]  ## Example 1
## arrWords = ["a", "aa", "aaa", "aaaa"]  ## Example 2
## arrWords = ["meet", "app", "code", "sky", "bold"]  ## Example 3
## arrWords = ["a", "ab", "abc", "abcd", "efghi"]  ## Example 4
arrWords = ["xyz", "w", "abcdefg", "hij"]  ## Example 5

arrOutput = [len(arrWords[nRow]) * len(arrWords[nCol]) for nRow in range(len(arrWords) - 1) for nCol in range(nRow + 1, len(arrWords)) if not (set(arrWords[nRow]) & set(arrWords[nCol]))]

print (0 if len(arrOutput) == 0 else max(arrOutput))
