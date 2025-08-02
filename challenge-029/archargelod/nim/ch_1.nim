#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[parseutils, strutils]

proc expandBraces(input: string): string =
  let start = input.skipUntil('{')
  let finish = start + input.skipUntil('}', start)

  let (before, after) = (input[0..<start], input[finish+1..^1])
  for middle in input[start+1..<finish].split(','):
    result.add before & middle & after & '\n'

when isMainModule:
  import std/unittest

  const
    Test = "Perl {Daily,Weekly,Monthly,Yearly} Challenge"
    Expected = """
Perl Daily Challenge
Perl Weekly Challenge
Perl Monthly Challenge
Perl Yearly Challenge
"""

  suite "Brace expansion":
    test "":
      check Test.expandBraces() == Expected
