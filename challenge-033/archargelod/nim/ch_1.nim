#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, tables, streams]

proc countLetters(filename: string): CountTable[char] =
  let f = newFileStream(filename)
  defer:
    f.close()
  while not f.atEnd():
    let c = f.readChar()
    if c in Letters:
      result.inc(c)

proc main =
  var counts = countLetters("/usr/share/dict/words")
  counts.sort()
  for c, cnt in counts:
    echo c, ": ", cnt

when isMainModule:
  main()
