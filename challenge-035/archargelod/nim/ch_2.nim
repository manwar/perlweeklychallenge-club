#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, tables, parseutils, streams]

const
  MorseToChar = {
    "-----" : '0',
    ".----" : '1',
    "..---" : '2',
    "...--" : '3',
    "....-" : '4',
    "....." : '5',
    "-...." : '6',
    "--..." : '7',
    "---.." : '8',
    "----." : '9',
    ".-"    : 'a',
    "-..."  : 'b',
    "-.-."  : 'c',
    "-.."   : 'd',
    "."     : 'e',
    "..-."  : 'f',
    "--."   : 'g',
    "...."  : 'h',
    ".."    : 'i',
    ".---"  : 'j',
    "-.-"   : 'k',
    ".-.."  : 'l',
    "--"    : 'm',
    "-."    : 'n',
    "---"   : 'o',
    ".--."  : 'p',
    "--.-"  : 'q',
    ".-."   : 'r',
    "..."   : 's',
    "-"     : 't',
    "..-"   : 'u',
    "...-"  : 'v',
    ".--"   : 'w',
    "-..-"  : 'x',
    "-.--"  : 'y',
    "--.."  : 'z',
    ".-.-.-": '.',
    "--..--": ',',
    "..--..": '?',
    "-.-.--": '!',
    "-....-": '-',
    "-..-." : '/',
    ".--.-.": '@',
    "-.--." : '(',
    "-.--.-": ')',
  }.toTable()

proc parseBinaryMorse(data: openarray[byte]): string =
  var binString = ""
  for b in data:
    binString &= cast[int](b).toBin(8)
  binString = binString.strip(chars = {'0'}) # might be unnecessary

  var morseWord = ""

  var ind = 0
  while ind < binString.len:
    let tokenLength = binString.skipUntil('0', ind)
    case tokenLength
    of 1:
      morseWord.add '.'
    of 3:
      morseWord.add '-'
    else:
      raise newException(ValueError, "Incorrectly formatted binary data")

    let gapLength = binString.skipUntil('1', ind + tokenLength)
    case gapLength
    of 0: # last character
      result.add MorseToChar[morseWord]
    of 1: discard
    of 3:
      result.add MorseToChar[morseWord]
      morseWord.setLen(0)
    of 7:
      result.add MorseToChar[morseWord]
      result.add ' '
      morseWord.setLen(0)
    else:
      raise newException(ValueError, "Incorrectly formatted binary data")

    ind += tokenLength + gapLength

proc readBinaryMorse(filename: string): string =
  var buffer: seq[byte]
  var f = newFileStream("message")
  while not f.atEnd:
    buffer.add f.readUint8()
  f.close
  parseBinaryMorse(buffer)

when isMainModule:
  import std/[unittest]

  const
    Test = [168'u8, 238, 227, 184, 128, 226, 42, 56, 10, 142, 46, 138, 58, 59, 160]
    Expected = "some test string"

  suite "Decode binary morse code":
    test "Decode a simple message":
      check parseBinaryMorse(Test) == Expected

    test "Decode message from part 1":
      check readBinaryMorse("message") == Expected
