import std/[algorithm]

proc maxGap(s:var seq[int]):int =
  if s.len < 2: return 0
  var temp,mx:int
  s.sort()
  for i in countup(0, s.len-1, 2):
    temp = abs(s[i] - s[i+1])
    if temp > mx: mx = temp
  for i in 0..s.len-2:
    if abs(s[i] - s[i+1]) == mx: result += 1
    
var
  s1:seq[int] = @[2,5,8,1]
  s2:seq[int] = @[3]
  
echo maxGap(s1)
echo maxGap(s2)

