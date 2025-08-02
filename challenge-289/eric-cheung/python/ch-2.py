
import random

def GetWordShuffle (strInput):
    arrChar = [nIndx for nIndx, charLoop in enumerate(strInput) if charLoop.isalpha()]

    arrSubChar = [nIndx for nIndx in arrChar[1:-1]]
    random.shuffle(arrSubChar)

    return strInput[:arrChar[0] + 1] + "".join([strInput[nIndx] for nIndx in arrSubChar]) + strInput[arrChar[-1]]

## strInput = "Perl"  ## Example 1
strInput = "According to a researcher (sic) at Cambridge University, it doesn't matter in what order the letters in a word are, the only important thing is that the first and last letter be at the right place. The rest can be a total mess and you can still read it without problem. This is because the human mind does not read every letter by itself but the word as a whole."  ## Example 2

strOutput = " ".join([GetWordShuffle(strLoop) for strLoop in strInput.split(" ")])

print (strOutput)
