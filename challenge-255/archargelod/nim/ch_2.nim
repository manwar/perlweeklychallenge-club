#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, parseutils, tables]

proc mostFrequentWord(paragraph: string, banned: string): string =
  var counts: CountTable[string]

  var index = 0
  while true:
    index += paragraph.skipUntil(Letters, index)
    let length = paragraph.skipWhile(Letters, index)
    index += length

    if index >= paragraph.len:
      break

    let word = paragraph[index - length ..< index]
    if word != banned:
      counts.inc(word)

  counts.largest.key

when isMainModule:
  import std/unittest

  suite "required tests":
    test "Example 1":
      check mostFrequentWord(
        "Joe hit a ball, the hit ball flew far after it was hit.",
        "hit"
      ) == "ball"
    test "Example 2":
      check mostFrequentWord(
        "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.",
        "the"
      ) == "Perl"
