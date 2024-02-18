#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
proc revSame(s1, s2: string): bool =
  if s1.len != s2.len: return false
  for i in 1..s1.len:
    if s1[i-1] != s2[^i]:
      return false
  true

proc countPairs(list: openarray[string]): int =
  for i, item in list[0 .. ^2]:
    for word in list[i+1 .. ^1]:
      if revSame(item, word):
        inc result

when isMainModule:
  import std/unittest

  suite "required tests":
    test "one pair":
      check ["de", "ba", "cd", "ed"].countPairs() == 1
    test "no pairs":
      check ["aa", "ba", "cd", "ed"].countPairs() == 0
    test "two pairs":
      check ["uv", "qp", "st", "vu", "mn", "pq"].countPairs() == 2
