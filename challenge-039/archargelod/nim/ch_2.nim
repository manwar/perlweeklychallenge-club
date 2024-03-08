#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/strutils

proc popExcept[T](stack: var seq[T]): T =
  if stack.len < 1:
    raise newException(ValueError, "Stack is Empty")
  stack.pop()

proc evaluateRPN*(expression: string): float =
  var stack: seq[float]
  for token in expression.splitWhitespace():
    if token in ["+", "-", "*", "/"]:
      let val2 = stack.popExcept()
      let val1 = stack.popExcept()
      case token
      of "+": stack.add val1 + val2
      of "-": stack.add val1 - val2
      of "*": stack.add val1 * val2
      of "/": stack.add val1 / val2
    else:
      stack.add parseFloat(token)

  if stack.len == 1:
    stack[0]
  else:
    raise newException(ValueError, "Invalid expression")

when isMainModule:
  import std/unittest

  suite "Reverse Polish Notation":
    test "Basic Subtraction":
      check evaluateRPN("3 2 -") == 1.0

    test "Multiple Operations":
      check evaluateRPN("3 4 + 2 *") == 14.0

    test "Division":
      check evaluateRPN("10 2 /") == 5.0

    test "Float Operations":
      check evaluateRPN("3.5 2.5 +") == 6.0

    test "Empty Stack Error":
      expect ValueError:
        discard evaluateRPN("2 +")

    test "Invalid Expression Error":
      expect ValueError:
        discard evaluateRPN("2 3 + 4")

    test "Invalid Float Literal Error":
      expect ValueError:
        discard evaluateRPN("10.5.3 2 +")
