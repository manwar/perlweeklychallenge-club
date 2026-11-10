
def GetLongestLenPath(strInput):
    nMaxLen = 0
    objPathLen = {-1: 0}

    for strLineLoop in strInput.split("\n"):
        nLvlDepth = strLineLoop.count("\t")
        strName = strLineLoop.replace("\t", "")

        arrFileName = strName.split(".")
        bIsFile = len(arrFileName) > 1 and len(arrFileName[1]) >= 3 

        if bIsFile:
            nCurLen = objPathLen[nLvlDepth - 1] + len(strName) + nLvlDepth
            nMaxLen = max(nMaxLen, nCurLen)
        else:
            objPathLen[nLvlDepth] = objPathLen[nLvlDepth - 1] + len(strName)

    return nMaxLen


## strFileSystem = "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"  ## Example 1
## strFileSystem = "file1.txt\nfile2.ext\na.png"  ## Example 2
## strFileSystem = "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"  ## Example 3
## strFileSystem = "root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt"  ## Example 4
strFileSystem = "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"  ## Example 5

print (GetLongestLenPath(strFileSystem))
