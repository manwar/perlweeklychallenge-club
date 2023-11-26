
## Example 1
## arrStr = ["ad", "bd", "aaab", "baa", "badab"]
## strAllowed = "ab"

## Example 2
## arrStr = ["a", "b", "c", "ab", "ac", "bc", "abc"]
## strAllowed = "abc"

## Example 3
arrStr = ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"]
strAllowed = "cad"

arrOutput = []

for strLoop in arrStr:
    arrTemp = [charLoop for charLoop in set(strLoop) if charLoop not in strAllowed]
    if len(arrTemp) == 0:
        arrOutput.append(strLoop)

print (len(arrOutput))
