import std/[sequtils,tables]

proc mostFrequentEven(s:seq[int]):int =
  var t = toCountTable(s.filterIt(it mod 2 == 0))
  if all(s,proc(x:int):bool = x mod 2 != 0): return -1
  if toSeq(t.values).len == toSeq(t.values).deduplicate.len:
    return min(toSeq(t.keys))
  return foldl(toSeq(t.keys), (if t[a] == t[b]: a else: b))

echo mostFrequentEven(@[1,1,2,6,2])
echo mostFrequentEven(@[1,3,5,7])
echo mostFrequentEven(@[6,4,4,6,1])

