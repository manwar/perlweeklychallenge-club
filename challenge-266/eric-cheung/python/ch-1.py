
## Example 1
## strLine_01 = "Mango is sweet"
## strLine_02 = "Mango is sour"

## Example 2
## strLine_01 = "Mango Mango"
## strLine_02 = "Orange"

## Example 3
strLine_01 = "Mango is Mango"
strLine_02 = "Orange is Orange"

arrLineSplit_01 = strLine_01.split()
arrUniqLine_01 = [strLoop for strLoop in set(arrLineSplit_01) if arrLineSplit_01.count(strLoop) == 1]

arrLineSplit_02 = strLine_02.split()
arrUniqLine_02 = [strLoop for strLoop in set(arrLineSplit_02) if arrLineSplit_02.count(strLoop) == 1]

arrUnCommonWord = [strLoop for strLoop in arrUniqLine_01 if not strLoop in arrUniqLine_02]
arrUnCommonWord = arrUnCommonWord + [strLoop for strLoop in arrUniqLine_02 if not strLoop in arrUniqLine_01]

## print (arrUniqLine_01)
## print (arrUniqLine_02)
print (arrUnCommonWord)
