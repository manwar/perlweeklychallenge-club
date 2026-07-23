from itertools import product

def GetReplaceQuestMark(strInputStr):
    nNumQues = strInputStr.count("?")
    arrCombin = product(["0", "1"], repeat = nNumQues)
    strTemplate = strInputStr.replace("?", "{}")

    return [strTemplate.format(*arrCombo) for arrCombo in arrCombin]

## strInput = "01??0"  ## Example 1
## strInput = "101"  ## Example 2
## strInput = "???"  ## Example 3
## strInput = "1?10"  ## Example 4
strInput = "1?1?0"  ## Example 5

arrResult = GetReplaceQuestMark(strInput)

print (arrResult)