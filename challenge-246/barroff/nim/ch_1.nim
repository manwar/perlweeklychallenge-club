#!/usr/bin/env -S nim e --hints:off
import std/[cmdline, parseutils, random, sequtils]

proc six_out_of_fortynine[T: SomeInteger](count: T = 6) =
  var
    lotteryNumbers = toSeq(1..49)
  # set up rng
  randomize()
  # shuffle the numbers
  shuffle(lotteryNumbers)
  for i in lotteryNumbers[0..count - 1]:
    echo i

proc main() =
  if paramCount() != 0:
    var
      parsedInt: int
    for argument in commandLineParams():
      if parseInt(argument, parsedInt, 0) != 0:
        six_out_of_fortynine(parsedInt)
        return
  six_out_of_fortynine()

main()
