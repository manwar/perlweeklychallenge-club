
## Example 1
## strSentence_01 = "apple banana apple"
## strSentence_02 = "banana orange"

## Example 2
## strSentence_01 = "cat dog"
## strSentence_02 = "bird fish"

## Example 3
## strSentence_01 = "the quick brown fox"
## strSentence_02 = "the quick"

## Example 4
## strSentence_01 = "hello"
## strSentence_02 = "hello"

## Example 5
strSentence_01 = "blue blue red"
strSentence_02 = "red green green yellow"

objSetSentence_01 = set([strLoop for strLoop in strSentence_01.split(" ")])
objSetSentence_02 = set([strLoop for strLoop in strSentence_02.split(" ")])

arrOutput = []
arrOutput.extend([strLoop for strLoop in objSetSentence_01 if strLoop not in objSetSentence_02])
arrOutput.extend([strLoop for strLoop in objSetSentence_02 if strLoop not in objSetSentence_01])

print (arrOutput)