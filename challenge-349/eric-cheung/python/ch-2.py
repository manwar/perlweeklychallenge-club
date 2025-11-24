
## strPath = "ULD"  ## Example 1
## strPath = "ULDR"  ## Example 2
## strPath = "UUURRRDDD"  ## Example 3
## strPath = "UURRRDDLLL"  ## Example 4
strPath = "RRUULLDDRRUU"  ## Example 5

nX = 0
nY = 0

for charLoop in strPath:
    nX = nX + (-1 if charLoop == "L" else 1 if charLoop == "R" else 0)
    nY = nY + (-1 if charLoop == "D" else 1 if charLoop == "U" else 0)

print (nX == 0 and nY == 0)
