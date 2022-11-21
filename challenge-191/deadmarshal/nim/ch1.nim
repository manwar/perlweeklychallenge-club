import std/[algorithm,strformat]

proc twiceLargest(s:var seq[int]):int =
  s.sort(order = SortOrder.Descending)
  if s[0] >= (2 * s[1]): return 1
  return -1

var
  s1:seq[int] = @[1,2,3,4]
  s2:seq[int] = @[1,2,0,5]
  s3:seq[int] = @[2,6,3,1]
  s4:seq[int] = @[4,5,2,3]
  
echo fmt"{twiceLargest(s1):>2}"
echo fmt"{twiceLargest(s2):>2}"
echo fmt"{twiceLargest(s3):>2}"
echo fmt"{twiceLargest(s4):>2}"

