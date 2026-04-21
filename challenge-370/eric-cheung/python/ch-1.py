
## Example 1
## strParagraph = "Bob hit a ball, the hit BALL flew far after it was hit."
## arrBanned = ["hit"]

## Example 2
## strParagraph = "Apple? apple! Apple, pear, orange, pear, apple, orange."
## arrBanned = ["apple", "pear"]

## Example 3
## strParagraph = "A. a, a! A. B. b. b."
## arrBanned = ["b"]

## Example 4
## strParagraph = "Ball.ball,ball:apple!apple.banana"
## arrBanned = ["ball"]

## Example 5
strParagraph = "The dog chased the cat, but the dog was faster than the cat."
arrBanned = ["the", "dog"]

objMap = str.maketrans({"." : " ", "," : " ", "?" : " ", "!" : " ", ":" : " "})

arrWordList = [strLoop for strLoop in strParagraph.lower().translate(objMap).strip().split(" ") if strLoop and strLoop not in arrBanned]

## print (arrWordList)

objOutput = {strLoop : arrWordList.count(strLoop) for strLoop in set(arrWordList)}

print (max(objOutput, key = objOutput.get))
