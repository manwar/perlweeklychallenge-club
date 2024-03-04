#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[sets, strutils, sequtils]

proc longest(lines: sink openarray[string]): string =
  for line in lines:
    if line.len > result.len:
      result = line

proc longestCommonSubstring(lines: openarray[string]): string =
  var substrings: HashSet[string]

  let first = lines[0]
  for i in 0 .. first.high:
    for j in i .. first.high:
      if i == 0 and j == first.high: continue
      substrings.incl first[i .. j]

  for line in lines:
    var newSubstrings: HashSet[string]
    for sub in substrings:
      if sub in line:
        newSubstrings.incl sub
    substrings = newSubstrings

  substrings.toSeq.longest()


when isMainModule:
  import std/unittest

  suite "Longest common substring":
    test "Example 1":
      check longestCommonSubstring(["ABABC", "BABCA", "ABCBA"]) == "ABC"
