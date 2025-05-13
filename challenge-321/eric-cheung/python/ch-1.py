
## arrNums = [1, 2, 4, 3, 5, 6]  ## Example 1
## arrNums = [0, 2, 4, 8, 3, 5]  ## Example 2
arrNums = [7, 3, 1, 0, 5, 9]  ## Example 3

arrNums = sorted(arrNums)

arrAvg = []

while len(arrNums) > 0:
    nMax = arrNums[-1]
    nMin = arrNums[0]

    arrAvg.append((nMax + nMin) / 2)

    arrNums.pop(-1)
    arrNums.pop(0)

print (len(set(arrAvg)))
