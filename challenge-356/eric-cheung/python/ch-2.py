
## strResult = "HAHAHH"  ## Example 1
## strResult = "HHHHHH"  ## Example 2
## strResult = "HHHAHA"  ## Example 3
## strResult = "HAHAAH"  ## Example 4
strResult = "HAAHAA"  ## Example 5

## === Week 1 ===
arrWin_Week_01 = []
arrWin_Week_01.append(2 if strResult[0] == "H" else 7)
arrWin_Week_01.append(3 if strResult[1] == "H" else 6)
arrWin_Week_01.append(4 if strResult[2] == "H" else 5)

arrWin_Week_01 = sorted(arrWin_Week_01)
## === Week 1 ===

## === Week 2 ===
arrWin_Week_02 = []
arrWin_Week_02.append(1 if strResult[3] == "H" else arrWin_Week_01[2])
arrWin_Week_02.append(arrWin_Week_01[0] if strResult[4] == "H" else arrWin_Week_01[1])

arrWin_Week_02 = sorted(arrWin_Week_02)
## === Week 2 ===

nChampion = (arrWin_Week_02[0] if strResult[5] == "H" else arrWin_Week_02[1])
nRunnerUp_1st = (arrWin_Week_02[1] if strResult[5] == "H" else arrWin_Week_02[0])

print ("Team " + str(nChampion) + " defeated Team " + str(nRunnerUp_1st))
