
from datetime import datetime

strDateFormat = "%Y-%m-%d"
dYearDay = 365.2425


## Example 1
## strDate_01 = "2019-02-10"
## strDate_02 = "2022-11-01"


## Example 2
## strDate_01 = "2020-09-15"
## strDate_02 = "2022-03-29"


## Example 3
## strDate_01 = "2019-12-31"
## strDate_02 = "2020-01-01"


## Example 4
## strDate_01 = "2019-12-01"
## strDate_02 = "2019-12-31"


## Example 5
## strDate_01 = "2019-12-31"
## strDate_02 = "2020-12-31"


## Example 6
## strDate_01 = "2019-12-31"
## strDate_02 = "2021-12-31"


## Example 7
## strDate_01 = "2020-09-15"
## strDate_02 = "2021-09-16"


## Example 8
strDate_01 = "2019-09-15"
strDate_02 = "2021-09-16"


objDate_01 = datetime.strptime(strDate_01, strDateFormat)
objDate_02 = datetime.strptime(strDate_02, strDateFormat)

nDiffDays = (objDate_02 - objDate_01).days
nDiffYears = int(nDiffDays / dYearDay)
nDiffDays = nDiffDays - int(nDiffYears * dYearDay)

strDiff = ""

if nDiffYears > 0:
    strDiff = strDiff + str(nDiffYears)
    if nDiffYears > 1:
        strDiff = strDiff + " years"
    else:
        strDiff = strDiff + " year"


if nDiffDays > 0:
    if strDiff:
        strDiff = strDiff + " "

    strDiff = strDiff + str(nDiffDays)

    if nDiffDays > 1:
        strDiff = strDiff + " days"
    else:
        strDiff = strDiff + " day"

print (strDiff)
