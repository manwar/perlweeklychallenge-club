#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
proc merge(s1, s2: string): string =
  let shortHigh = min(s1.len, s2.len) - 1

  for i, c in s1[0..shortHigh]:
    result.add c
    result.add s2[i]

  if s1.len > s2.len:
    result.add s1[shortHigh+1..^1]
  elif s2.len > s1.len:
    result.add s2[shortHigh+1..^1]

when isMainModule:
  import std/unittest

  const
    S1 = ["abcd", "abc", "abcde"]
    S2 = ["1234", "12345", "123"]
    Expected = ["a1b2c3d4", "a1b2c345", "a1b2c3de"]

  suite "required tests":
    test "empty":
      check merge("", "") == ""
    test "equal length":
      check merge(S1[0], S2[0]) == Expected[0]
    test "second is longer":
      check merge(S1[1], S2[1]) == Expected[1]
    test "first is longer":
      check merge(S1[2], S2[2]) == Expected[2]
