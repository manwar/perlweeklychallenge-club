#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/sequtils

proc allOccurencesCountsUnique(numbers: seq[int]): bool =
  var counts: seq[int]
  var uniq: seq[int]
  for n in numbers:
    if n in uniq: continue
    let cnt = numbers.count(n)
    if cnt in counts: return false
    counts.add cnt
    uniq.add n
  true

when isMainModule:
  import std/unittest

  const
    Test = [
      @[1,2,2,1,1,3],
      @[1,2,3],
      @[-2,0,1,-2,1,1,0,1,-2,9]
    ]
    Expected = [true, false, true]

  suite "Unique Occurrences":
    test "Example 1":
      check allOccurencesCountsUnique(Test[0]) == Expected[0]
    test "Example 2":
      check allOccurencesCountsUnique(Test[1]) == Expected[1]
    test "Example 3":
      check allOccurencesCountsUnique(Test[2]) == Expected[2]
