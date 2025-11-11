
from datetime import datetime
from dateutil.parser import parse

## strInputDate = "1st Jan 2025"  ## Example 1
## strInputDate = "22nd Feb 2025"  ## Example 2
## strInputDate = "15th Apr 2025"  ## Example 3
## strInputDate = "23rd Oct 2025"  ## Example 4
strInputDate = "31st Dec 2025"  ## Example 5

strOutputDateFormat = "%Y-%m-%d"

objDate = parse(strInputDate)

print (objDate.strftime(strOutputDateFormat))

