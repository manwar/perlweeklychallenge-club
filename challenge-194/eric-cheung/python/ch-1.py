
## strTimeInput = "?5:00"  ## Example 1
## strTimeInput = "?3:00"  ## Example 2
## strTimeInput = "1?:00"  ## Example 3
## strTimeInput = "2?:00"  ## Example 4
## strTimeInput = "12:?5"  ## Example 5
strTimeInput = "12:5?"  ## Example 6

nPos = strTimeInput.find("?")

if nPos == 0:
    for nLoop in [2, 1]:
        nHour = int(str(nLoop) + strTimeInput[1])
        if nHour <= 23:
            print (str(nLoop))
            break
elif nPos == 1:
    for nLoop in [9, 8, 7, 6, 5, 4, 3, 2, 1]:
        nHour = int(strTimeInput[0] + str(nLoop))
        if nHour <= 23:
            print (str(nLoop))
            break
elif nPos == 3:
    for nLoop in [5, 4, 3, 2, 1]:
        nMin = int(str(nLoop) + strTimeInput[4])
        if nMin <= 59:
            print (str(nLoop))
            break
elif nPos == 4:
    for nLoop in [9, 8, 7, 6, 5, 4, 3, 2, 1]:
        nMin = int(strTimeInput[3] + str(nLoop))
        if nMin <= 59:
            print (str(nLoop))
            break
