#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc jaroSimilarity*(s1, s2: string): float =
  if min(s1.len, s2.len) < 1: raise newException(ValueError, "strings can't be empty")
  let margin = int max(s1.len, s2.len) div 2 - 1
  var
    matches = (newSeq[bool](s1.len), newSeq[bool](s2.len))
    m: int
    t: float

  # number of matches in order
  for i, c in s1:
    var left = max(s2.low, i - margin)
    let right = max(s2.low, min(s2.high, i + margin))
    var pos = s2[left .. right].find(c)
    if pos == -1: continue

    while left+pos < s2.high and matches[1][left+pos]:
      left = left + pos + 1 # shift search start past the previous find
      pos = s2[left .. right].find(c)

    if left + pos > s2.high:
      pos = -1

    matches[0][i] = true
    matches[1][left + pos] = true
    inc m

  if m == 0: return 0

  # count transpositions
  var mInd2 = 0
  for mInd1, matched in matches[0]:
    if not matched: continue
    while not matches[1][mInd2]:
      inc mInd2
    if s1[mInd1] != s2[mInd2]:
      t += 1
    inc mInd2
  t /= 2

  1/3 * (m/s1.len + m/s2.len + (m.float - t)/m.float)

proc jaroWinklerSimilarity*(s1, s2: string, p = 0.1): float =
  if min(s1.len, s2.len) < 1: raise newException(ValueError, "strings can't be empty")
  if p < 0 or p > 0.25:
    raiseAssert("P should not exceed 0.25, as similarity could become > 1")

  # common prefix
  var l: int
  for i, c in s1[0 .. min(s1.high, 3)]:
    if i > s2.high or s2[i] != c:
      break
    l = i + 1

  let simj = jaroSimilarity(s1, s2)
  simj + l.float * p * (1 - simj)

proc jaroWinklerDistance*(s1, s2: string, p = 0.1): float =
  if min(s1.len, s2.len) < 1: raise newException(ValueError, "strings can't be empty")
  1 - jaroWinklerSimilarity(s1, s2, p)

when isMainModule:
  import std/[unittest]

  proc approxEqual(a, b, tolerance: float): bool =
    return abs(a - b) <= tolerance

  suite "Jaro-Winkler string distance":
    test "similarity of 'faremviel' and 'farmville' is around 0.88":
      check approxEqual(jaroSimilarity("faremviel", "farmville"), 0.88, 0.01)
