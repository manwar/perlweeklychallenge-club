
## strInput = "abbc"  ## Example 1
## strInput = "xyzyyxz"  ## Example 2
strInput = "xzxz"  ## Example 3

arrStr = [*strInput]
arrUniqStr = list(set(arrStr))

arrCount = []
arrUniqCount = []

for charLoop in arrUniqStr:
    arrCount.append(arrStr.count(charLoop))

## print (arrCount)

arrUniqCount = list(set(arrCount))

if len(arrUniqCount) == 1 or len(arrUniqCount) > 2:
    print ("0")
elif abs(arrUniqCount[0] - arrUniqCount[1]) == 1:
    print ("1")
else:
    print ("0")
