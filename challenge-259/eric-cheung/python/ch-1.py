
from datetime import datetime, timedelta

strDateFormat = "%Y-%m-%d"

## Example 1
## strStartDate = "2018-06-28"
## nOffset = 3
## arrBankHoliday = ["2018-07-03"]

## Example 2
strStartDate = "2018-06-28"
nOffset = 3
arrBankHoliday = []

objOutputDate = datetime.strptime(strStartDate, strDateFormat)

while nOffset > 0:
    objOutputDate = objOutputDate + timedelta(days = 1)
    if objOutputDate.weekday() < 5 and not objOutputDate.strftime(strDateFormat) in arrBankHoliday:
        nOffset = nOffset - 1

print (objOutputDate.strftime(strDateFormat))
