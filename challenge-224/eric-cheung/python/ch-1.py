
## Example 1
## strSource = "abc"
## strTarget = "xyz"

## Example 2
## strSource = "scriptinglanguage"
## strTarget = "perl"

## Example 3
strSource = "aabbcc"
strTarget = "abc"

arrSrcSplit = [charLoop for charLoop in strSource]
arrTargetSplit = [charLoop for charLoop in strTarget]

print (set(arrTargetSplit).issubset(set(arrSrcSplit)))
