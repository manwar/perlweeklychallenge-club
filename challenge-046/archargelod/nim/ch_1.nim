#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, tables]

proc decrypt(lines: seq[string]): string =
  for i in 0..lines[0].high:
    if lines[0][i] in Whitespace: continue
    var count = newCountTable[char]()
    for line in lines:
      count.inc(line[i])
    result.add count.largest.key

when isMainModule:
  import std/unittest

  const
    Test = [
      """
      H x l 4 !
      c e - l o
      z e 6 l g
      H W l v R
      q 9 m # o""".dedent(),
      """
      P + 2 l ! a t o
      1 e 8 0 R $ 4 u
      5 - r ] + a > /
      P x w l b 3 k \
      2 e 3 5 R 8 y u
      < ! r ^ ( ) k 0""".dedent()
    ]

    Expected = ["Hello", "PerlRaku"]

  suite "Cryptic Message":
    test "message: Hello":
      check decrypt(Test[0].splitLines()) == Expected[0]
    test "message: PerlRaku":
      check decrypt(Test[1].splitLines()) == Expected[1]
