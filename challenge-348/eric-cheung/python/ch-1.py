
## strInput = "textbook"  ## Example 1
## strInput = "book"  ## Example 2
## strInput = "AbCdEfGh"  ## Example 3
## strInput = "rhythmmyth"  ## Example 4
strInput = "UmpireeAudio"  ## Example 5

arrVowel = ["a", "e", "i", "o", "u"]

nLen = int(len(strInput) / 2)

nVowel_01 = len([charLoop for charLoop in strInput[:nLen].lower() if charLoop in arrVowel])
nVowel_02 = len([charLoop for charLoop in strInput[nLen:].lower() if charLoop in arrVowel])

print (nVowel_01 == nVowel_02 and nVowel_01 > 0)
