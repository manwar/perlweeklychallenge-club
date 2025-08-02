#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, parseutils, math]

type
  Sign = enum
    None
    Plus
    Minus

proc evaluate(s: string): int =
  var index = 0
  let length = s.skipWhile(Digits, index)
  result = parseInt(s[0..<length])
  index += length

  while index < s.len:
    doAssert s[index] in {'-', '+'}
    let addition = s[index] == '+'
    inc index

    let length = s.skipWhile(Digits, index)
    let num = parseInt(s[index..<index+length])
    index += length

    if addition:
      result += num
    else:
      result -= num

proc toTrinary(n, digits: int): string =
  var n = n
  while n > 0:
    result.insert $(n mod 3)
    n = n div 3

  result = result.align(digits, '0')

iterator allSignPermutations(n: int): seq[Sign] =
  var buf = newSeqOfCap[Sign](n)
  for i in 1..<3^n:
    for digit in i.toTrinary(n):
      buf.add (
        case digit
        of '0': None
        of '1': Plus
        of '2': Minus
        else:
          raiseAssert("Invalid digit.")
      )
    yield buf
    buf.setLen(0)

when isMainModule:
  const Expression = "123456789"
  for signs in allSignPermutations(Expression.len - 1):
    var newExpression = Expression
    var shift = 1
    for i, sign in signs:
      case sign
      of None:
        discard
      of Plus:
        newExpression.insert("+", i + shift)
        inc shift
      of Minus:
        newExpression.insert("-", i + shift)
        inc shift

    if evaluate(newExpression) == 100:
      echo newExpression, " == 100"
      break
