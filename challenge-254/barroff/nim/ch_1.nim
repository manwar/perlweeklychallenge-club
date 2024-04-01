import std/[sugar, unittest]

from std/math import sqrt
from std/sequtils import map, toSeq

# run tests with following command:
# nim c -r ch_1.nim

proc three_power(n: Natural): bool =
  let
    powers = map(toSeq(0..int(sqrt(to!float(n)))), x => x * x * x)
  return n in powers

suite "three power":
  test "27":
    check(three_power(27) == true)

  test "0":
    check(three_power(0) == true)

  test "6":
    check(three_power(6) == false)
