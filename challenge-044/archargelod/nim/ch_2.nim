#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
## The rules:
##   With every move you can either double or add 1.
##   Get 200 from 1 with the smallest number of moves
## Solution:
##  Reverse the problem: get from 200 to 1. If value is even - divide by 2,
##  else subtract 1.

type Move = enum
  Div2 = "/ 2"
  Sub1 = "- 1"
  Mul2 = "* 2"
  Add1 = "+ 1"

proc minimumStepsTo1(start: int): seq[Move] =
  var value = start

  while value > 1:
    if value mod 2 == 0:
      value = value div 2
      result.add Div2
    else:
      dec value
      result.add Sub1

when isMainModule:
  import std/[unittest, sequtils, algorithm]

  const
    Test = 200
    Expected = [
      [Div2, Div2, Div2, Sub1, Div2, Div2, Div2, Sub1, Div2],
      [Mul2, Add1, Mul2, Mul2, Mul2, Add1, Mul2, Mul2, Mul2],
    ]

  suite "Make it $200":
    test "steps 200 -> 1":
      check minimumStepsTo1(Test) == Expected[0]
    test "steps 1 -> 200":
      let reverse = minimumStepsTo1(Test).mapIt(if it == Div2: Mul2 else: Add1).reversed()
      check reverse == Expected[1]
