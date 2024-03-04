#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, parseutils, options]

type Url = object
  scheme, userinfo, host: string
  port = 80
  path, query, fragment: string

template consume(input: string, chars: openarray[char]): bool =
  var res = true
  for i, c in chars:
    if ind < input.len and input[ind] == c:
      inc ind
    else:
      ind -= i
      res = false
      break
  res

proc parseUrl(input: string): Url =
  result = Url()

  var ind = 0
  let schemeEnd = input.skipUntil({':'}, ind)
  result.scheme = input[0 ..< schemeEnd]
  ind += schemeEnd

  if not input.consume(":"):
    raiseAssert("expected ':'")

  if input.consume("//"):
    # user:password pair (optional)
    let userinfoEnd = input.skipUntil({'@'}, ind)
    if ind + userinfoEnd < input.len:
      result.userinfo = input[ind ..< ind + userinfoEnd]
      ind += userInfoEnd + 1

    # hostname
    let hostEnd = input.skipUntil({':', '/'}, ind)
    if ind + hostEnd > input.high:
      raiseAssert("expected ':' or '/'")
    result.host = input[ind ..< ind + hostEnd]
    ind += hostEnd

    # port (optional)
    if input.consume(":"):
      let portEnd = input.skipWhile(Digits, ind)
      result.port = parseInt input[ind ..< ind + portEnd]
      ind += portEnd

  # path
  let pathEnd = input.skipUntil({'?', '#'}, ind)
  result.path = input[ind ..< ind + pathEnd]
  ind += pathEnd

  # query (optional)
  if input.consume("?"):
    let queryEnd = input.skipUntil({'#'}, ind)
    result.query = input[ind ..< ind + queryEnd]
    ind += queryEnd

  # match fragment (optional)
  if input.consume("#"):
    result.fragment = input[ind ..^ 1]

when isMainModule:
  import std/unittest

  const
    Test = [
      "jdbc://user:password@localhost:3306/pwc?profile=true#h1",
      "file:/home/test/hello.txt"
    ]
    Expected = [
      Url(
        scheme: "jdbc",
        userinfo: "user:password",
        host: "localhost",
        port: 3306,
        path: "/pwc",
        query: "profile=true",
        fragment: "h1",
      ),
      Url(
        scheme: "file",
        port: 80,
        path: "/home/test/hello.txt",
      )
    ]

  suite "URL parsing":
    test "Example 1":
      check parseUrl(Test[0]) == Expected[0]

    test "Minimal Example":
      check parseUrl(Test[1]) == Expected[1]
