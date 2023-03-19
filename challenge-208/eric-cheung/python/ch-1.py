
## Example 1
## arrList_01 = ["Perl", "Raku", "Love"]
## arrList_02 = ["Raku", "Perl", "Hate"]

## Example 2
## arrList_01 = ["A", "B", "C"]
## arrList_02 = ["D", "E", "F"]

## Example 3
arrList_01 = ["A", "B", "C"]
arrList_02 = ["C", "A", "B"]

arrCommonList = [strLoop for strLoop in arrList_01 if strLoop in arrList_02]

if len(arrCommonList) > 0:
    arrCommonIndxSum = [arrList_01.index(strLoop) + arrList_02.index(strLoop) for strLoop in arrCommonList]
    arrMinIndx = [nIndx for nIndx, nLoop in enumerate(arrCommonIndxSum) if nLoop == min(arrCommonIndxSum)]
    arrMinList = [arrCommonList[nIndx] for nIndx in arrMinIndx]

    print (arrMinList)
else:
    print ([])
