
from random import randint

## Example 1
arrNames = ["Mr. Wall", "Mrs. Wall", "Mr. Anwar", "Mrs. Anwar", "Mr. Conway", "Mr. Cross"]
nMaxShareFamilyGift = 0

## Example 2
## arrNames = ["Mr. Wall", "Mrs. Wall", "Mr. Anwar"]
## nMaxShareFamilyGift = 1

arrGiftFrom = [-1] * len(arrNames)  ## List storing the index storing who the gift is sent

for nIndxLoop, strNameLoop in enumerate(arrNames):

    if nMaxShareFamilyGift == 0:
        arrAvailList = [nIndx for nIndx, strLoop in enumerate(arrNames) if strLoop != strNameLoop and strLoop.split(" ")[-1] != strNameLoop.split(" ")[-1] and arrGiftFrom[nIndx] == -1]
    else:
        arrAvailList = [nIndx for nIndx, strLoop in enumerate(arrNames) if strLoop != strNameLoop and strLoop.split(" ")[-1] == strNameLoop.split(" ")[-1] and arrGiftFrom[nIndx] == -1]

        nMaxShareFamilyGift = nMaxShareFamilyGift - 1

    nGiftTo = arrAvailList[randint(0, len(arrAvailList) - 1)]
    arrGiftFrom[nGiftTo] = nIndxLoop

    print (strNameLoop + " --> " + arrNames[nGiftTo])

    print ("")

print ("From : " + " | ".join(arrNames))
print ("To : " + " | ".join([strNameLoop for nIndxLoop, strNameLoop in sorted(zip(arrGiftFrom, arrNames))]))
