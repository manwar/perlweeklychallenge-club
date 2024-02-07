#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import tables

func findOddChar*(base, mixed: string): char =
  if mixed.len - base.len != 1:
    raiseAssert("Mixed string should be exactly 1 character longer than base.")

  var mixedLetters = mixed.toCountTable
  for c in base:
    mixedLetters.inc(c, -1)

  for key, val in mixedLetters:
    if val != 0:
      return key

when isMainModule:
  import std/unittest

  suite "required tests":
    test "Perl vs Preel":
      check findOddChar("Perl", "Preel") == 'e'
    test "Weekly vs Weeakly":
      check findOddChar("Weekly", "Weeakly") == 'a'
    test "Box vs Boxy":
      check findOddChar("Box", "Boxy") == 'y'
