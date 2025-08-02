
## arrInputStr = ["abc", "abb", "ab"]  ## Example 1
## arrInputStr = ["ayz", "cyz", "xyz"]  ## Example 2
arrInputStr = ["yza", "yzb", "yzc"]  ## Example 3

nExistCommonPosStr = -1
for nPos in range(min([len(strLoop) for strLoop in arrInputStr]), 0, -1):
    bExistCommonStr = True
    strCommon = arrInputStr[0][:nPos]
    for strLoop in arrInputStr[1:]:
        if strLoop[:nPos] != strCommon:
            bExistCommonStr = False
            break
    if bExistCommonStr:
        nExistCommonPosStr = nPos
        break

if nExistCommonPosStr > -1:
    arrOutput = [len(strLoop) - nExistCommonPosStr for strLoop in arrInputStr]
    print (sum(arrOutput))
else:
    print (-1)
