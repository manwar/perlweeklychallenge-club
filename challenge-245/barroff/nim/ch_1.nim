import std/[algorithm, sequtils, sugar, tables, unittest]

# run tests with following command:
# nim c -r ch_1.nim

proc sortLanguage(lang: openArray[string], positions: openArray[int]): seq[string] =
  var
    posHash = initTable[int, string]()
  setlen(result, len(lang))
  for x in zip(positions, lang):
    posHash[x[0]] = x[1]
  for i in sorted(positions):
    result[i - 1] = posHash[i]

suite "sort language":
  test """"["perl", "c", "python"], [2, 1, 3]""":
    let
      lang = ["perl", "c", "python"]
      positions = [2, 1, 3]
      expected = ["c", "perl", "python"]
      res = sortLanguage(lang, positions)

    check(expected == res)

  test """"["c++", "haskell", "java"], [1, 3, 2]""":
    let
      lang = ["c++", "haskell", "java"]
      positions = [1, 3, 2]
      expected = ["c++", "java", "haskell"]
      res = sortLanguage(lang, positions)

    check(expected == res)
