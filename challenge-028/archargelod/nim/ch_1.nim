#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[mimetypes, os]

proc contentsVerbose(filename: string): string =
  if not fileExists(filename):
    raise newException(IOError, "'" & filename & "' does not exist.")

  let
    db = newMimetypes()
    (_, name, ext) = filename.splitFile()
    # couldn't think of other way to check contents without reading the file ¯\_(0_0)_/¯
    mimetype = db.getMimetype(ext, "data")

  "The file '" & name & ext & "' is of type '" & mimetype & "'."

when isMainModule:
  echo contentsVerbose("/usr/share/mime/image/gif.xml")
