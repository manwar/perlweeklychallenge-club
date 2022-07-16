import strutils
import std/strformat

proc is_esthetic(num: int): bool =
  let n = intToStr(num)
  for i in 1..len(n)-1:
    if abs(int(n[i]) - int(n[i-1])) != 1:
      return false
  return true

for test in [5456, 120, 121, 23456, 2346, 7654567, 765467]:
  if is_esthetic(test):
    echo fmt("{test:<9}"), " is esthetic"
  else:
    echo fmt("{test:<9}"), " is not esthetic"
