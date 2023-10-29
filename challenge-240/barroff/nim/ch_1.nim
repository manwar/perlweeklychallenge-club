import std/[sequtils, strutils, sugar, unicode, unittest]

# run tests with following command:
# nim c -r ch_1.nim

proc acronym(chk: string, str: openArray[string]): bool =
  result = toLower(chk) == join(map(str, x => toLowerAscii(x[0])), "")

suite "acronym":
  test "\"ppp\" [\"Perl\", \"Python\", \"Pascal\"]":
    let
      chk = "ppp"
      str = ["Perl", "Python", "Pascal"]
    check(acronym(chk, str) == true)

  test "\"rp\" [\"Perl\", \"Raku\"]":
    let
      chk = "rp"
      str = ["Perl", "Raku"]
    check(acronym(chk, str) == false)

  test "\"oac\" [\"Oracle\", \"Awk\", \"C\"]":
    let
      chk = "oac"
      str = ["Oracle", "Awk", "C"]
    check(acronym(chk, str) == true)
