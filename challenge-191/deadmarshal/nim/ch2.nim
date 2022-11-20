import std/[algorithm,sequtils]

proc isCute(s:seq[int]):bool =
  not (1..s.len).anyIt(it mod s[it-1] != 0 and s[it-1] mod it != 0)
  
proc cuteList(n:int):int =
  var
    s:seq[int] = (1..n).toSeq
  if isCute(s):
    inc result
  while s.nextPermutation():
    if isCute(s):
      inc result
      
echo cuteList(2)

