
from datetime import datetime
from calendar import monthrange

## Example 1
nYearInput = 2024
nMonthInput = 4
nWeekDayMonth = 3
nWeekDay = 2


## Example 2
## nYearInput = 2025
## nMonthInput = 10
## nWeekDayMonth = 2
## nWeekDay = 4


## Example 3
## nYearInput = 2026
## nMonthInput = 8
## nWeekDayMonth = 5
## nWeekDay = 3


nLastDay = monthrange(nYearInput, nMonthInput)[1]

nDay = 0
for nLoop in range(1, 8):
    objDateInput = datetime(nYearInput, nMonthInput, nLoop)
    if objDateInput.isoweekday() == nWeekDay:
        nDay = nLoop
        break

nDay = nDay + 7 * (nWeekDayMonth - 1)

if nDay <= nLastDay:
    print (nDay)
else:
    print (0)
