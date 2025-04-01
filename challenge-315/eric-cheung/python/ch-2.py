
import sys

## Example 1
## strSentence = "Perl is a my favourite language but Python is my favourite too."
## strFirstWord = "my"
## strSecondWord = "favourite"

## Example 2
## strSentence = "Barbie is a beautiful doll also also a beautiful princess."
## strFirstWord = "a"
## strSecondWord = "beautiful"

## Example 3
strSentence = "we will we will rock you rock you."
strFirstWord = "we"
strSecondWord = "will"

arrList = strSentence.replace(".", "").split(" ")

## print (arrList)

arrFirstWordIndx = [nIndx for nIndx, strLoop in enumerate(arrList) if strLoop == strFirstWord]
arrSecondWordIndx = [nIndx for nIndx, strLoop in enumerate(arrList) if strLoop == strSecondWord]

if len(arrFirstWordIndx) != len(arrSecondWordIndx):
    print ("Error 1")
    sys.exit()

if len(arrFirstWordIndx) == 0:
    print ("Error 2")
    sys.exit()

for nFirstIndx, nSecondIndx in zip(arrFirstWordIndx, arrSecondWordIndx):
    if nSecondIndx == nFirstIndx + 1:
        continue

    print ("Error 3")
    sys.exit()

arrOutput = [arrList[nIndx + 1] for nIndx in arrSecondWordIndx]

print (arrOutput)
