
from datetime import datetime

## strDate = "2025-02-02"  ## Example 1
## strDate = "2025-04-10"  ## Example 2
strDate = "2025-09-07"  ## Example 3

objDate = datetime.strptime(strDate, "%Y-%m-%d").timetuple()

print (objDate.tm_yday)
