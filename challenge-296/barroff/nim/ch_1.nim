import std/unittest

# run tests with following command:
# nim c -r ch_1.nim

proc string_compression(str: string): string =
  result = newStringOfCap(len(str))
  var
    c: char = str[0]
    repititions: int = 1

  for x in str[1..high(str)]:
    if c == x:
      inc(repititions)
    else:
      if repititions == 1:
        result &= c
      else:
        result &= $(repititions) & c
        repititions = 1
      c = x

  if repititions == 1:
    result &= c
  else:
    result &= $(repititions) & c

suite "string compression":
  test "abbc":
    check(string_compression("abbc") == "a2bc")

  test "aaabccc":
    check(string_compression("aaabccc") == "3ab3c")

  test "abcc":
    check(string_compression("abcc") == "ab2c")
