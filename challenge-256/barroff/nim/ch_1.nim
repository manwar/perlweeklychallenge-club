import std/[sugar, unittest]

from std/sequtils import countIt, filter, map
from std/unicode import reversed

# run tests with following command:
# nim c -r ch_1.nim

proc maximum_pairs(words: openArray[string]): int =
  let
    non_palindromes = filter(words, x => x != reversed(x))
    reversed_words = map(non_palindromes, x => reversed(x))
  result = countIt(reversed_words, it in non_palindromes) div 2


suite "maximum pairs":
  test """("ab", "de", "ed", "bc")""":
    let
      words = ["ab", "de", "ed", "bc"]

    check(maximum_pairs(words) == 1)

  test """("aa", "ba", "cd", "ed")""":
    let
      words = ["aa", "ba", "cd", "ed"]

    check(maximum_pairs(words) == 0)

  test """("uv", "qp", "st", "vu", "mn", "pq")""":
    let
      words = ["uv", "qp", "st", "vu", "mn", "pq"]

    check(maximum_pairs(words) == 2)
