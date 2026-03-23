
from re import match

## strTime = "?2:34"  ## Example 1
## strTime = "?4:?0"  ## Example 2
## strTime = "??:??"  ## Example 3
## strTime = "?3:45"  ## Example 4
strTime = "2?:15"  ## Example 5

arrHourMin = [("0" + str(nHour))[-2:] + ":" + ("0" + str(nMin))[-2:] for nHour in range(24) for nMin in range(60)]

strPattern = strTime.replace("?", "\d")

arrOutput = [strLoop for strLoop in arrHourMin if match(strPattern, strLoop)]

## print (arrOutput)
print (len(arrOutput))
