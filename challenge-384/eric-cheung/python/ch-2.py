
## strBinary = "0101"  ## Example 1
## strBinary = "000111"  ## Example 2
## strBinary = "000011"  ## Example 3
## strBinary = "10011100"  ## Example 4
strBinary = "00000"  ## Example 5

arrOutput = []

for nRow in range(0, len(strBinary) - 1):
    for nCol in range(nRow + 1, len(strBinary), 2):
        strCheck = strBinary[nRow:nCol + 1]

        nMidIndx = int(len(strCheck) / 2)

        strPrev = strCheck[:nMidIndx]
        strAfter = strCheck[nMidIndx:]

        nZeroCountPrev = strPrev.count("0")
        nOneCountPrev = strPrev.count("1")

        nZeroCountAfter = strAfter.count("0")
        nOneCountAfter = strAfter.count("1")

        nZeroCount = nZeroCountPrev + nZeroCountAfter
        nOneCount = nOneCountPrev + nOneCountAfter

        if nZeroCount != nOneCount:
            continue

        if nZeroCountPrev != 0 and nZeroCountAfter != 0 and nOneCountPrev != 0 and nOneCountAfter != 0:
            continue

        arrOutput.append(strCheck)

print (set(arrOutput))
