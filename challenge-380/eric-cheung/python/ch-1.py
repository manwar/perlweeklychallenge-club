from collections import Counter

## strInput = "banana"  ## Example 1
## strInput = "teestett"  ## Example 2
## strInput = "aeiouuaa"  ## Example 3
## strInput = "rhythm"  ## Example 4
strInput = "x"  ## Example 5

arrInput = list(strInput)

arrVowel = ["a", "e", "i", "o", "u"]

arrVowelCount = [charLoop for charLoop in arrInput if charLoop in arrVowel]
arrConsonantCount = [charLoop for charLoop in arrInput if charLoop not in arrVowel]

nVowelCount = (0 if len(arrVowelCount) == 0 else Counter(arrVowelCount).most_common(1)[0][1])
nConsonantCount = (0 if len(arrConsonantCount) == 0 else Counter(arrConsonantCount).most_common(1)[0][1])

print (nVowelCount + nConsonantCount)