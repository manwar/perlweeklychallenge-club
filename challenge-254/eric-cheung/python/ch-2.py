
## Reference
## https://www.w3resource.com/python-exercises/basic/python-basic-1-exercise-71.php
## https://www.geeksforgeeks.org/reverse-vowels-given-string/

## strInput = "Raku"  ## Example 1
## strInput = "Perl"  ## Example 2
## strInput = "Julia"  ## Example 3
strInput = "Uiua"  ## Example 4

arrVowel = [charLoop for charLoop in strInput.lower() if charLoop in ["a", "e", "i", "o", "u"]]

strOutput = ""

for nIndx, charLoop in enumerate(strInput.lower()):
    if charLoop in ["a", "e", "i", "o", "u"]:
        strOutput = strOutput + arrVowel[-1]
        del arrVowel[-1]
    else:
        strOutput = strOutput + charLoop

strOutput = strOutput.title()

print (strOutput)
