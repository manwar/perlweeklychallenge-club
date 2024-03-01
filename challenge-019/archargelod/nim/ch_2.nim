#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[parseutils, strutils]

proc wrap*(text: var string, lineWidth: Positive = 80) =
  var spaceLeft: int = lineWidth
  var index = 0
  while index < text.high:
    let wordWidth = text.skipUntil(Whitespace, index)
    let spaceWidth = text.skipWhile(Whitespace, index + wordWidth)

    #echo (text[index..<index + wordWidth], wordWidth + spaceWidth, spaceLeft)
    if wordWidth + spaceWidth > spaceLeft:
      text.insert("\n", index)
      spaceLeft = lineWidth - (wordWidth + spaceWidth)
      inc index # for added newLine
    else:
      spaceLeft -= wordWidth + spaceWidth
    index += wordWidth + spaceWidth

proc wrapped*(text: sink string, lineWidth: Positive = 80): string =
  result = text
  result.wrap(lineWidth)

when isMainModule:
  import std/unittest

  const
    Text = """
A simple way to do word wrapping is to use a greedy algorithm that puts as many words on a line as possible, then moving on to the next line to do the same until there are no more words left to place. This method is used by many modern word processors, such as OpenOffice.org Writer and Microsoft Word. This algorithm always uses the minimum possible number of lines but may lead to lines of widely varying lengths."""
    Expected = """
A simple way to do word wrapping is to use a greedy algorithm that puts as many 
words on a line as possible, then moving on to the next line to do the same 
until there are no more words left to place. This method is used by many modern 
word processors, such as OpenOffice.org Writer and Microsoft Word. This 
algorithm always uses the minimum possible number of lines but may lead to 
lines of widely varying lengths."""

  suite "Greedy line wrapping":
    test "wikipedia paragraph":
      check Text.wrapped(80) == Expected
