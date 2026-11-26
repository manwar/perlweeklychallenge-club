
from collections import Counter

## To solve this problem (classic LeetCode 423: Reconstruct Original Digits from English), count the occurrences of unique identifying letters for each English digit word in a specific order.

## How It Works

## Even when scrambled, certain letters only appear in one specific digit's spelling. Once you count and subtract those digits, other letters become unique to the remaining digits:
## 1. First Pass (Unique Letters):
	## • z only appears in zero  (0)
	## • w only appears in two   (2)
	## • u only appears in four  (4)
	## • x only appears in six   (6)
	## • g only appears in eight (8)
## 2. Second Pass (Remaining Unique Letters):
	## • h appears in three and eight --> subtract 8 to get three (3)
	## • f appears in four and five --> subtract 4 to get five    (5)
	## • s appears in six and seven --> subtract 6 to get seven   (7)
## 3. Third Pass (Final Letters):
	## • o appears in zero, one, two, four --> subtract 0, 2, 4 to get one    (1)
	## • i appears in five, six, eight, nine --> subtract 5, 6, 8 to get nine (9)


def GetReconstructDigits(strInput):
    objCharCount = Counter(strInput)

    ## Array to store the count of each digit (0 - 9)
    arrDigitCount = [0] * 10

    ## 1. Identify digits with unique characters
    arrDigitCount[0] = objCharCount["z"]
    arrDigitCount[2] = objCharCount["w"]
    arrDigitCount[4] = objCharCount["u"]
    arrDigitCount[6] = objCharCount["x"]
    arrDigitCount[8] = objCharCount["g"]

    ## 2. Identify digits using remaining unique characters
    arrDigitCount[3] = objCharCount["h"] - arrDigitCount[8]
    arrDigitCount[5] = objCharCount["f"] - arrDigitCount[4]
    arrDigitCount[7] = objCharCount["s"] - arrDigitCount[6]

    ## 3. Identify the last two digits
    arrDigitCount[1] = objCharCount["o"] - arrDigitCount[0] - arrDigitCount[2] - arrDigitCount[4]
    arrDigitCount[9] = objCharCount["i"] - arrDigitCount[5] - arrDigitCount[6] - arrDigitCount[8]

    ## Build the final ascending string
    return "".join([str(nDigit) * arrDigitCount[nDigit] for nDigit in range(10)])


## strGiven = "zroezerotwotwotwo"  ## Example 1
## strGiven = "sveeneinght"  ## Example 2
## strGiven = "onenineninefive"  ## Example 3
## strGiven = "zeroonetwothreeeightfivesixsevenninefour"  ## Example 4
strGiven = "ninenineninenine"  ## Example 5

print (GetReconstructDigits(strGiven))  
