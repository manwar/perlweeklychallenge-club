
from datetime import datetime, timedelta

## Example 1
## strSource = "02:30"
## strTarget = "02:45"

## Example 2
## strSource = "11:55"
## strTarget = "12:15"

## Example 3
## strSource = "09:00"
## strTarget = "13:00"

## Example 4
## strSource = "23:45"
## strTarget = "00:30"

## Example 5
strSource = "14:20"
strTarget = "15:25"

arrMin = [60, 15, 5, 1]
strTimeFormat = "%H:%M"

nDayAdd = (1 if strSource > strTarget else 0)

objSource = datetime.strptime(strSource, strTimeFormat)
objTarget = datetime.strptime(strTarget, strTimeFormat) + timedelta(days = nDayAdd)

nMinDiff = int((objTarget - objSource).total_seconds() / 60)
nOperation = 0

for nMinLoop in arrMin:
    nOperation = nOperation + int(nMinDiff / nMinLoop)
    nMinDiff = nMinDiff - int(nMinDiff / nMinLoop) * nMinLoop

print (nOperation)
