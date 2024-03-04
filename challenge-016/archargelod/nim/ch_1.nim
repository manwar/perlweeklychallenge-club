#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc percent(value: float, pct: 0..100): float =
  value / 100'f * pct.float

proc largestPieceOfPieIndex(): int =
  var amount = 1'f
  var largest = 0'f

  for i in 1..100:
    let piece = amount.percent(i)
    if piece <= largest:
      return i - 1
    largest = piece
    amount -= piece

when isMainModule:
  import std/strformat

  let index = largestPieceOfPieIndex()
  echo &"{index}th guest gets the largest piece of pie."
