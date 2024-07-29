
## Ref.
## https://leetcode.ca/2022-07-26-2315-Count-Asterisks/

## strInput = "p|*e*rl|w**e|*ekly|"  ## Example 1
## strInput = "perl"  ## Example 2
strInput = "th|ewe|e**|k|l***ych|alleng|e"  ## Example 3

if strInput.count("|") < 2:
    print (strInput.count("*"))
else:
    arrSplit = strInput.split("|")
    strResult = "".join([arrSplit[nIndx] for nIndx in range(len(arrSplit)) if nIndx % 2 == 0])
    print (strResult.count("*"))
