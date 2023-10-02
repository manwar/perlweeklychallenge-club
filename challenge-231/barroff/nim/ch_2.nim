import std/[sequtils, strutils, re, unittest]

# run tests with following command:
# nim c -r ch_2.nim

proc is_senior(s: string): bool =
  result = false
  var
    m = [""]
  if match(s, re"\d{10}[A-Z](\d\d)\d\d", m):
    let
      age: int = parseInt(m[0])
    return age >= 60

proc senior_citizens(passengers: openArray[string]): int =
  len(filter(passengers, is_senior))

suite "senior citizens":
  test "[\"7868190130M7522\", \"5303914400F9211\", \"9273338290F4010\"]":
    let
      s = ["7868190130M7522", "5303914400F9211", "9273338290F4010"]
    check(senior_citizens(s) == 2)

  test "[\"1313579440F2036\", \"2921522980M5644\"]":
    let
      s = ["1313579440F2036", "2921522980M5644"]
    check(senior_citizens(s) == 0)
