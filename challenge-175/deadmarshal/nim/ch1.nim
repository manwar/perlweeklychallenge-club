import std/os,std/strformat,std/strutils

if paramCount() != 1:
  stderr.writeLine("No arg(s) provided!")
  quit(1)

proc isLeapYear(year:int):bool =
  if year mod 100 == 0: return year mod 400 == 0
  return year mod 4 == 0

proc lastSunday(year:int) =
  var
    days = @[31,28,31,30,31,30,31,31,30,31,30,31]
    week = year * 365 + 97 * (year-1) + 4
  if isLeapYear(year): days[1] = 29
  for month in 0..<days.len:
    week = (week + days[month]) mod 7
    echo fmt"{year}-{month+1:02}-{days[month] - week}"
        
lastSunday(parseInt(paramStr(1)))
