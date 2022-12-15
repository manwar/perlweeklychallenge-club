import std/sequtils

proc intToSeq(n:int):seq[int] =
  var cp = n
  while cp != 0:
    result.add(cp mod 10)
    cp = cp div 10
    
proc specialIntegers(n:int):int =
  for i in 1..n:
    let digits = intToSeq(i)
    if digits.len == deduplicate(digits).len: result += 1
    
echo specialIntegers(15)
echo specialIntegers(35)

