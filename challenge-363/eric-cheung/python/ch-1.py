
from word2number import w2n
import sys

## strInput = "aa — two vowels and zero consonants"  ## Example 1
## strInput = "iv — one vowel and one consonant"  ## Example 2
## strInput = "hello — three vowels and two consonants"  ## Example 3
## strInput = "aeiou — five vowels and zero consonants"  ## Example 4
strInput = "aei — three vowels and zero consonants"  ## Example 5

arrVowel = ["a", "e", "i", "o", "u"]

arrWordSplit = strInput.split(" — ")

if len(arrWordSplit) != 2:
    print ("Invalid Input")
    sys.exit()

strWordCheck = arrWordSplit[0]
strWordDesc = arrWordSplit[1]

## print (strWordCheck)
## print (strWordDesc)

nVowelCount = len([charLoop for charLoop in strWordCheck if charLoop in arrVowel])
nConsonantCount = len(strWordCheck) - nVowelCount

## print (nVowelCount)
## print (nConsonantCount)

arrVowelConsonantDesc = strWordDesc.split(" and ")

if len(arrVowelConsonantDesc) != 2:
    print ("Invalid Desc")
    sys.exit()

strVowelCountDesc = arrVowelConsonantDesc[0].split(" vowel")[0]
strConsonantCountDesc = arrVowelConsonantDesc[1].split(" consonant")[0]

## print (strVowelCountDesc)
## print (strConsonantCountDesc)

nVowelCheck = w2n.word_to_num(strVowelCountDesc)
nConsonantCheck = w2n.word_to_num(strConsonantCountDesc)

## print (nVowelCheck)
## print (nConsonantCheck)

bIsClaimTrue = (nVowelCount == nVowelCheck and nConsonantCount == nConsonantCheck)

print (bIsClaimTrue)
