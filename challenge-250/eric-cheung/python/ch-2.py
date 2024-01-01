
def GetAlphaNumLen (strInput):
    return int(strInput) if strInput.isnumeric() else len(strInput)

## arrAlphaNumStr = ["perl", "2", "000", "python", "r4ku"]  ## Example 1
arrAlphaNumStr = ["001", "1", "000", "0001"]  ## Example 2

arrOutput = [GetAlphaNumLen(strLoop) for strLoop in arrAlphaNumStr]
print (max(arrOutput))
