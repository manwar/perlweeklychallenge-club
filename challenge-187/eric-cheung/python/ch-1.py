
import datetime

nYear = 2022

## DD-MM

## Example 1
strFooStartDate = "12-01"
strFooEndDate = "20-01"

strBarStartDate = "15-01"
strBarEndDate = "18-01"


## Example 2
# # strFooStartDate = "02-03"
# # strFooEndDate = "12-03"

# # strBarStartDate = "13-03"
# # strBarEndDate = "14-03"


## Example 3
# # strFooStartDate = "02-03"
# # strFooEndDate = "12-03"

# # strBarStartDate = "11-03"
# # strBarEndDate = "15-03"


## Example 4
# # strFooStartDate = "30-03"
# # strFooEndDate = "05-04"

# # strBarStartDate = "28-03"
# # strBarEndDate = "02-04"


def GetConvDate(strInputDate):

    arrInputDate = strInputDate.split("-")
    return datetime.datetime(nYear, int(arrInputDate[1]), int(arrInputDate[0]))


objFooStartDate = GetConvDate(strFooStartDate)
objFooEndDate = GetConvDate(strFooEndDate)
objBarStartDate = GetConvDate(strBarStartDate)
objBarEndDate = GetConvDate(strBarEndDate)


bFlag = False


if objFooStartDate < objBarStartDate:
    if objFooEndDate >= objBarStartDate:
        objStartDate = objBarStartDate
        bFlag = True
else:
    if objBarEndDate >= objFooStartDate:
        objStartDate = objFooStartDate
        bFlag = True


if bFlag:
    if objFooEndDate < objBarEndDate:
        objEndDate = objFooEndDate
    else:
        objEndDate = objBarEndDate

    objDay = objEndDate - objStartDate
    nDay = objDay.days + 1

    if nDay > 1:
        print(str(nDay) + " days")
    else:
        print(str(nDay) + " day")
else:
    print ("0 day")
