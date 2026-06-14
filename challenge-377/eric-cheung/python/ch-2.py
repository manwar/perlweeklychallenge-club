
from itertools import combinations

## arrList = ["a", "aba", "ababa", "aa"]  ## Example 1
## arrList = ["pa", "papa", "ma", "mama"]  ## Example 2
## arrList = ["abao", "ab"]  ## Example 3
## arrList = ["abab", "abab"]  ## Example 4
## arrList = ["ab", "abab", "ababab"]  ## Example 5
arrList = ["abc", "def", "ghij"]  ## Example 6

arrPairs = list(combinations(arrList, 2))

arrOutput = [arrLoop for arrLoop in arrPairs if arrLoop[0].endswith(arrLoop[1]) and arrLoop[0].startswith(arrLoop[1]) or arrLoop[1].endswith(arrLoop[0]) and arrLoop[1].startswith(arrLoop[0])]

print (len(arrOutput))
