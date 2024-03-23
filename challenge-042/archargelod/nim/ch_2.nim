#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/random

const
  OpeningBracket = '('
  ClosingBracket = ')'
  Brackets = [OpeningBracket, ClosingBracket]

proc genRandomBrackets: string =
  result = newString(rand(1..60) * 2)
  for c in result.mItems:
    c = Brackets[rand(Brackets.low..Brackets.high)]

proc isBalanced(brackets: string): bool =
  var stack: seq[char]
  for c in brackets:
    if c == OpeningBracket:
      stack.add ClosingBracket
    else:
      if stack.len < 1: return false
      discard stack.pop()
  stack.len == 0

when isMainModule:
  randomize()

  while true:
    let brackets = genRandomBrackets()
    if brackets.isBalanced():
      echo brackets, " is balanced!"
      break
