#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[times, strformat]

proc asInt(c: char): int =
  assert c in '0'..'9'
  c.ord - '0'.ord

proc palindromeDates(yearRange: Slice[int]) =
  assert yearRange.a <= yearRange.b
  assert yearRange.b < 10000

  for year in yearRange:
    let yearString = &"{year:04}"
    let day = yearString[^3].asInt * 10 + yearString[^4].asInt
    if day notin 1..31: continue

    let month = yearString[^1].asInt * 10 + yearString[^2].asInt
    if month notin 1..12: continue

    let formatted = $month & $day & yearString

    try:
      let date = formatted.parse("MMddyyyy")
      echo "There is a palindrome date in year ", $year, ": ", formatted,
           " or ", date.format("MMM-dd-yyyy")
    except TimeParseError:
      discard

proc main =
  palindromeDates(2000 .. 2999)

when isMainModule:
  main()
