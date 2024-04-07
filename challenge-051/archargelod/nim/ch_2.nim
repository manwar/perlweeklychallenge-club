#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[sequtils, math]

proc isColorFul(number: int): bool =
  let digits = ($number).mapIt(it.ord - '0'.ord)
  var uniq: set[int16]

  template testUniq(n: int16) =
    if n in uniq:
      return false
    uniq.incl n

  for winLen in 1..digits.len:
    for ind in 0 .. digits.len - winLen:
      let product = digits.toOpenArray(ind, ind + winLen - 1).prod()
      testUniq(int16 product)

  true

proc allColorful3Digits*(): seq[int] =
  for i in 100..999:
    if i.isColorFul():
      result.add i

when isMainModule:
  echo "All colorful 3-digit numbers: ", allColorful3Digits()
