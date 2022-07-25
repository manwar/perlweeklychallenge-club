
## Remark
## https://stackoverflow.com/questions/42950/how-to-get-the-last-day-of-the-month

import calendar


nGivenYear = 2022
nSunWeekNum = 6
nWeekNumDay = 7


for nMonthLoop in range(1, 13):
    [nFirstDayWeekNum, nLastDay] = calendar.monthrange(nGivenYear, nMonthLoop)

    nSunDay = 1 + nSunWeekNum - nFirstDayWeekNum + nWeekNumDay * 4

    if nSunDay > nLastDay:
        nSunDay = nSunDay - nWeekNumDay

    print (str(nGivenYear) + "-" + ("0" + str(nMonthLoop) if nMonthLoop < 10 else str(nMonthLoop)) + "-" + str(nSunDay))
