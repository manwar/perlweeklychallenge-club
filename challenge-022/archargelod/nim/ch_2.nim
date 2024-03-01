#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/tables

proc lzwEncoded(input: string): seq[int] =
  var dict: Table[string, int]
  for c in 'a'..'z':
    dict[$c] = dict.len
  dict[" "] = dict.len

  var ind = 0
  var word = ""
  while ind < input.len:
    word = $input[ind]

    while ind < input.high and word & input[ind+1] in dict:
      word &= input[ind+1]
      inc ind

    result.add dict[word]
    if ind < input.high:
      dict[word & input[ind+1]] = dict.len
    inc ind

proc lzwDecoded(input: openarray[int]): string =
  var dict: Table[int, string]
  for c in 'a'..'z':
    dict[dict.len] = $c
  dict[dict.len] = " "

  var lastEmitted = ""
  for i, encoded in input:
    if encoded in dict:
      let word = dict[encoded]
      if i > 0:
        dict[dict.len] = lastEmitted & word[0]

      result &= word
      lastEmitted = word
    else:
      let v = lastEmitted & lastEmitted[0]
      dict[dict.len] = v

      result &= v
      lastEmitted = v


when isMainModule:
  import std/unittest

  const
    Test = "further refinements include reserving a code to indicate that the code table should be cleared and restored to its initial state a clear code typically the first value immediately after the values for the individual alphabet characters and a code to indicate the end of data a stop code typically one greater than the clear code the clear code lets the table be reinitialized after it fills up which lets the encoding adapt to changing patterns in the input data smart encoders can monitor the compression efficiency and clear the table whenever the existing table no longer matches the input well"

  suite "Lempel–Ziv–Welch (LZW) compression algorithm":
    test "long text":
      check lzwEncoded(Test).lzwDecoded == Test
