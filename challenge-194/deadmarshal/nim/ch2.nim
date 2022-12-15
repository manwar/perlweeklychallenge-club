import std/[tables,sequtils,algorithm]

proc frequencyEqualizer(str:string):bool =
  var
    s = toSeq(toCountTable(str).values)
  sort(s,Descending)
  if s[0] == s[1]+1 and s[^1] == s[1]:
    return true
  return false
  
echo frequencyEqualizer("abbc")
echo frequencyEqualizer("xyzyyxz")
echo frequencyEqualizer("xzxz")

