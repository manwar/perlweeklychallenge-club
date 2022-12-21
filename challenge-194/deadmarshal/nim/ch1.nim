import std/[sequtils,strutils]

proc digital_clock(str:string):int =
  var s = toSeq(str)
  if s[0] == '?':
    if parseInt($s[1]) < 4: return 2 else: return 1
  elif s[1] == '?':
    if parseInt($s[0]) < 2: return 9 else: return 3
  elif s[3] == '?': return 5 else: return 9
    
echo digital_clock("?5:00")
echo digital_clock("?3:00")
echo digital_clock("1?:00")
echo digital_clock("2?:00")
echo digital_clock("12:?5")
echo digital_clock("12:5?")

