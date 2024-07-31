
## strInput = "perl"  ## Example 1
## strInput = "book"  ## Example 2
strInput = "good morning"  ## Example 3

arrVowel = ["a", "e", "i", "o", "u"]

arrVowelCount = [charLoop for charLoop in strInput if charLoop in arrVowel]

print (len(arrVowelCount) % 2 == 0)
