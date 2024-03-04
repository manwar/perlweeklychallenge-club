#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[sets]

const USStates = [
  "al", "ak", "az", "ar", "ca", "co", "ct", "de", "fl", "ga", "hi", "id", "il", "in",
  "ia", "ks", "ky", "la", "me", "md", "ma", "mi", "mn", "ms", "mo", "mt", "ne", "nv",
  "nh", "nj", "nm", "ny", "nc", "nd", "oh", "ok", "or", "pa", "ri", "sc", "sd", "tn",
  "tx", "ut", "vt", "va", "wa", "wv", "wi", "wy"
].toHashSet()

proc isComposableFrom(word: string, syllables: HashSet[string]): bool =
  if word.len mod 2 != 0:
    return false

  for i in countUp(0, word.len - 2, 2):
    if word[i .. i + 1] notin syllables:
      return false

  true

proc longestWordFromSyllables(dictFile: string, syllables: HashSet[string]): string =
  let dict = open(dictFile)
  defer:
    dict.close()

  for word in lines dict:
    if word.len < result.len:
      continue
    if word.isComposableFrom syllables:
      result = word

when isMainModule:
  import std/strformat

  const DictPath = "/usr/share/dict/words"
  let res = DictPath.longestWordFromSyllables(USStates)

  echo &"Longest word composable from US 2-letter State names is '{res}'"
