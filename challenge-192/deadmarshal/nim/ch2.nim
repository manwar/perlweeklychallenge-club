import std/[math]

proc equalDistribution(s:seq[int]):int =
  var
    sum:int = sum(s)
    (avg,moves,sumPart) = (sum div s.len,0,0)
  if sum mod s.len == 0:
    for i in 0..<s.len:
      sumPart += s[i]
      moves += abs(sumPart - (avg * (i+1)))
    return moves
  return -1
    
echo equalDistribution(@[1,0,5])
echo equalDistribution(@[0,2,0])
echo equalDistribution(@[0,3,0])

