
## strSentence = "I love Perl"  ## Example 1
## strSentence = "Perl and Raku are friends"  ## Example 2
strSentence = "The Weekly Challenge"  ## Example 3

arrVowel = ["a", "e", "i", "o", "u"]

strOutput = ""
arrOutput = []

for nIndx, strLoop in enumerate(strSentence.split()):

    strOutput = (strLoop if strLoop[0].lower() in arrVowel else strLoop[1:] + strLoop[0])
    strOutput = strOutput + "ma" + "a" * (nIndx + 1)
    arrOutput.append(strOutput)

print (" ".join(arrOutput))
