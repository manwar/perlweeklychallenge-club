
from datetime import datetime

## arrTimeInput = ["00:00", "23:55", "20:00"]  ## Example 1
## arrTimeInput = ["01:01", "00:50", "00:57"]  ## Example 2
arrTimeInput = ["10:10", "09:30", "09:00", "09:55"]  ## Example 3

arrTimeMinDiff = []

for nIndxLoop_01 in range(0, len(arrTimeInput) - 1):
    for nIndxLoop_02 in range(nIndxLoop_01 + 1, len(arrTimeInput)):

        tLoop_01 = datetime.strptime(arrTimeInput[nIndxLoop_01], "%H:%M")
        tLoop_02 = datetime.strptime(arrTimeInput[nIndxLoop_02], "%H:%M")

        if tLoop_01 <= tLoop_02:
            tDiff = (tLoop_02 - tLoop_01).total_seconds()
        else:
            tDiff = (tLoop_01 - tLoop_02).total_seconds()

        arrTimeMinDiff.append(int(tDiff / 60))
        arrTimeMinDiff.append(24 * 60 - int(tDiff / 60))

print (min(arrTimeMinDiff))
