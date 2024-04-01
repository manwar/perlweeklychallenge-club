#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[parseutils, tables]

proc countUniqLines(input: string): CountTable[string] =
  var index = 0
  while index < input.len:
    let lineLength = input.skipUntil('\n', index)
    let line = input[index ..< index+lineLength]
    result.inc(line)

    index += lineLength + 1

when isMainModule:
  import std/unittest

  const
    Expected = {"apple": 3, "banana": 1, "cherry": 2}
    Test = """
apple
banana
apple
cherry
cherry
apple"""

  template checkTable(table, tuples: typed) =
    for (val, cnt) in tuples:
      check table[val] == cnt

  when defined(csv):
    for val, cnt in countUniqLines(Test):
      echo val, ',', cnt
  else:
    suite "Count instances":
      test "Example 1":
        checkTable(countUniqLines(Test), Expected)

