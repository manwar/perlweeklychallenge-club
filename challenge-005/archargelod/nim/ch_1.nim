#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, algorithm, sets]

let dict = block:
  var tmp: Hashset[string]
  for word in lines "/usr/share/dict/words":
    tmp.incl word
  tmp

proc allAnagrams(word: string): seq[string] =
  var tmp = word
  while tmp.nextPermutation():
    let word = tmp.join()
    if word in dict: result.add word

  tmp = word
  while tmp.prevPermutation():
    let word = tmp.join()
    if word in dict: result.add word

when isMainModule:
  import std/unittest

  const
    TestWord1 = "god"
    ExpectedAnagrams1 = sorted ["dog"]

  suite "All anagrams for word":
    test "should return all anagrams for \'god\'":
      check sorted(allAnagrams(TestWord1)) == ExpectedAnagrams1
