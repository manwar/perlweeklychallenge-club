import std/unittest

from std/sequtils import map
from std/strutils import Letters, contains, parseInt

# run tests with following command:
# nim c -r ch_2.nim

proc alphanumeric_string_value(alphanumstr: openArray[string]): int =
  result = max(map(alphanumstr, proc(x: string): int =
    if contains(x, Letters):
      len(x)
    else:
      parseInt(x)
    ))

suite "alphanumeric string value":
  test """("perl", "2", "000", "python", "r4ku")""":
    let
      als = ["perl", "2", "000", "python", "r4ku"]

    check(alphanumeric_string_value(als) == 6)

  test """("001", "1", "000", "0001")""":
    let
      als = ["001", "1", "000", "0001"]

    check(alphanumeric_string_value(als) == 1)
