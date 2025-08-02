
## Example 1
## strSentence = "Perl Weekly Challenge"
## arrKey = ["l", "a"]

## Example 2
## strSentence = "Perl and Raku"
## arrKey = ["a"]

## Example 3
## strSentence = "Well done Team PWC"
## arrKey = ["l", "o"]

## Example 4
strSentence = "The joys of polyglottism"
arrKey = ["T"]

arrKeyLower = [charLoop.lower() for charLoop in arrKey]

nCount = 0
for wordLoop in strSentence.split():
    ## print (wordLoop)
    arrContain = [charLoop for charLoop in wordLoop.lower() if charLoop in arrKeyLower]
    if len(arrContain) == 0:
        nCount = nCount + 1

print (nCount)
