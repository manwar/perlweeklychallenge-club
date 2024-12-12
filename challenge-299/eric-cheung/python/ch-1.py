
def GetStrReplace (strInput):
    global arrWords

    for strWordLoop in arrWords:
        if len(strWordLoop) > len(strInput):
            continue

        if strWordLoop == strInput:
            return strInput

        if len(strWordLoop) == len(strInput):
            continue

        if strInput[:len(strWordLoop)] == strWordLoop:
            return strWordLoop

    return strInput


## Example 1
## arrWords = ["cat", "bat", "rat"]
## strSentence = "the cattle was rattle by the battery"

## Example 2
## arrWords = ["a", "b", "c"]
## strSentence = "aab aac and cac bab"

## Example 3
arrWords = ["man", "bike"]
strSentence = "the manager was hit by a biker"

## for strLoop in strSentence.split(" "):
    ## print (strLoop, GetStrReplace(strLoop))

arrOutput = [GetStrReplace(strLoop) for strLoop in strSentence.split(" ")]

print (" ".join(arrOutput))
