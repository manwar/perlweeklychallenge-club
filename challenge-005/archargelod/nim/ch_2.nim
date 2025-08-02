#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[algorithm, strutils, strformat, tables]

proc mostAnagramWord(dictfile: string): (seq[char], int) =
  var counts: CountTable[seq[char]]
  for word in lines dictFile:
    counts.inc word.sorted()

  counts.largest

proc main =
  let (val, cnt) = mostAnagramWord("/usr/share/dict/words")
  echo &"Word with most anagrams is '{val.join()}' with count of {$cnt} possible anagrams."

when isMainModule:
  main()
