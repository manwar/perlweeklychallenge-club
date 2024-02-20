#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

type
  NumberRange = tuple
    val, l: int

func `$`(s: NumberRange): string =
  if s.l == 0:
    $s.val
  elif s.l == 1:
    $s.val & ',' & $(s.val + s.l)
  else:
    $s.val & '-' & $(s.val + s.l)

func compactNumString*(numbers: openarray[int]): string =
  if numbers.len < 1: return result

  var range: NumberRange = (numbers[0], 0)
  for i, num in numbers[1..^1]:
    if num == range.val + range.l + 1:
      inc range.l
    else:
      result &= $range & ','
      range = (num, 0)

  result &= $range

when isMainModule:
  import std/unittest

  suite "Compact number lists":
    test "Example 1":
      check compactNumString([1,2,3,4,9,10,14,15,16]) == "1-4,9,10,14-16"
