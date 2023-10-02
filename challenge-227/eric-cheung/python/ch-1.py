
from datetime import datetime

nYearGiven = 2023  ## Example

nFri_13th_Count = len([nMonthLoop + 1 for nMonthLoop in range(12) if int(datetime(nYearGiven, nMonthLoop + 1, 13).strftime("%w")) == 5])

## for nMonthLoop in range(12):
    ## strWeekDay = datetime(nYearGiven, nMonthLoop + 1, 13).strftime("%w")
    ## if int(strWeekDay) == 5:
        ## nFri_13th_Count = nFri_13th_Count + 1

print (nFri_13th_Count)
