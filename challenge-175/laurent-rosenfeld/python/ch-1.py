from datetime import date,timedelta
import sys

def lastsundays (y):
  for m in range(1,13):
    if m == 12:
      year = y + 1
      month = 1
    else:
      year = y
      month = m + 1

    mthEnd = date(year, month, 1) - timedelta(days = 1)
    weekDay = mthEnd.weekday()
    lastSun = mthEnd - timedelta(days = (weekDay + 1) % 7)
    print(lastSun)

if len(sys.argv) == 2:
  year = int(sys.argv[1])
else:
  year = 2022

lastsundays(year)
