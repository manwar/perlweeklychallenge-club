
## nInputNum = 5  ## Example 1
nInputNum = 4  ## Example 2
## nInputNum = 6  ## Example 3

strBinFormat = bin(nInputNum)[2:]
strBinFlipFormat = "".join(["0" if strCharLoop == "1" else "1" for strCharLoop in strBinFormat])
nOuputDecFormat = int(strBinFlipFormat, 2)

print (str(nOuputDecFormat))
