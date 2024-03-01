#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[uri, strutils, parseutils]

template upd(mut, procedure: typed) =
  mut = procedure(mut)

proc normalizePercentEncoded(url: string): string =
  result = url

  template decodeUnreserved(s: string, i: int) =
    let hex = s[i+1..i+2].parseHexInt
    case hex
    of 0x41..0x5A, 0x61..0x7A, 0x30..0x39, 0x2D, 0x2E, 0x5F, 0x7E:
      s[i..i+2] = $hex.chr
    else:
      discard

  var index = 0
  while index < result.len:
    if result[index] == '%':
      result[index + 1].upd(toUpperAscii)
      result[index + 2].upd(toUpperAscii)
      result.decodeUnreserved(index)

      index += 2

    inc index

proc removeDotSegments(path: string): string =
  var stack: seq[string]
  var ind = 1
  while ind < path.len:
    let segmentLength = path.skipUntil('/', ind)
    let lastSegment = path[ind..<ind+segmentLength]

    case lastSegment
    of ".":
      discard
    of "..":
      stack.setLen(stack.len - 1)
    else:
      stack.add lastSegment

    ind += segmentLength + 1
  '/' & stack.join("/")


proc normalizeUrl(url: string): Uri =
  result = url.normalizePercentEncoded.parseUri

  result.scheme.upd(toLowerAscii)
  result.hostname.upd(toLowerAscii)

  result.path.upd(removeDotSegments)

  # convert no path to empty path
  if result.path.len < 1: result.path = "/"
  # remove default port for http
  if result.scheme == "http" and result.port == "80":
    result.port = ""

when isMainModule:
  import std/unittest

  const
    Test = "hTtP://Example.com:80/Foo/./././././bar/../baz"
    Expected = "http://example.com/Foo/baz"

  suite "URL normalization (RFC 3986)":
    test "Example 1":
      check $Test.normalizeUrl() == Expected
