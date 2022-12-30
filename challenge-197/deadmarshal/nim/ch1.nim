import std/[sequtils]

proc moveZero(s:var seq[int]):seq[int] =
  var count:int
  for e in s:
    if e == 0: count += 1
    else: result.add(e)
  result.add(repeat(0,count))

var
  s1:seq[int] = @[1,0,3,0,0,5]
  s2:seq[int] = @[1,6,4]
  s3:seq[int] = @[0,1,0,2,0]
      
echo moveZero(s1)
echo moveZero(s2)
echo moveZero(s3)

