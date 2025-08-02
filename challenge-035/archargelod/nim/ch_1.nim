#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, tables]

const
  MorseDot = "1"
  MorseDash = "111"
  MorseGap = "0"
  MorseCharGap = "00" # CharGap is Gap + Extra 2 zeroes = 3 zeroes total
  MorseWordGap = "0000" # WordGap is Gap + CharGap + Extra 4 zeroes = 7 zeroes total

  CharToMorse = {
    '0': "-----",
    '1': ".----",
    '2': "..---",
    '3': "...--",
    '4': "....-",
    '5': ".....",
    '6': "-....",
    '7': "--...",
    '8': "---..",
    '9': "----.",
    'a': ".-",
    'b': "-...",
    'c': "-.-.",
    'd': "-..",
    'e': ".",
    'f': "..-.",
    'g': "--.",
    'h': "....",
    'i': "..",
    'j': ".---",
    'k': "-.-",
    'l': ".-..",
    'm': "--",
    'n': "-.",
    'o': "---",
    'p': ".--.",
    'q': "--.-",
    'r': ".-.",
    's': "...",
    't': "-",
    'u': "..-",
    'v': "...-",
    'w': ".--",
    'x': "-..-",
    'y': "-.--",
    'z': "--..",
    '.': ".-.-.-",
    ',': "--..--",
    '?': "..--..",
    '!': "-.-.--",
    '-': "-....-",
    '/': "-..-.",
    '@': ".--.-.",
    '(': "-.--.",
    ')': "-.--.-",
  }.toTable()

proc normalizeWhitespace(input: string): string =
  var lastCharIsSpace = false
  for c in input:
    if c in Whitespace:
      if lastCharIsSpace:
        continue
      else:
        result.add c
        lastCharIsSpace = true
    else:
      result.add c
      lastCharIsSpace = false

proc toBinaryMorse*(input: string): seq[byte] =
  var binString = ""
  let input = input.strip().normalizeWhitespace()
  for c in input:
    if c == ' ':
      binString.add MorseWordGap
      continue

    let c = c.toLowerAscii()
    if c in CharToMorse:
      let morse = CharToMorse[c]
      for c in morse:
        case c
        of '.': binString.add MorseDot
        of '-': binString.add MorseDash
        else: raiseAssert("Invalid morse character:" & c)
        binString.add MorseGap
      binString.add MorseCharGap

  binString.setLen(binString.len - MorseGap.len - MorseCharGap.len)

  for i in countUp(0, binString.high, 8):
    var section = binString[i..min(i+7, binString.high)]
    if section.len < 8:
      section &= '0'.repeat(8 - section.len)
    result.add cast[byte](parseBinInt(section))

when isMainModule:
  import std/[unittest]

  const
    Test = "	Some test 	sTriNg    "
    Expected = [168'u8, 238, 227, 184, 128, 226, 42, 56, 10, 142, 46, 138, 58, 59, 160]

  suite "Encode binary morse code":
    test "Encode simple message":
      check toBinaryMorse(Test) == Expected
    test "Save message as file for part 2":
      writeFile("message", toBinaryMorse(Test))
