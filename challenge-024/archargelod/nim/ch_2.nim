#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[os, tables, strutils, strformat, sugar]

type InvIndex* = object
  indexes: Table[string, set[uint16]]
  files: Table[uint16, string]

proc initInvertedIndex(dir: string): InvIndex =
  result = InvIndex()
  for file in dir.walkDir():
    if file.kind != pcFile: continue

    let fileId = result.files.len.uint16
    result.files[fileId] = file.path.splitPath.tail

    for line in lines file.path:
      for word in line.split(Whitespace + PunctuationChars):
        if word.len < 1: continue
        let word = word.toLower()
        if word notin result.indexes:
          result.indexes[word] = {fileId.uint16}
        else:
          result.indexes[word].incl fileId.uint16

proc `$`(db: InvIndex): string =
  const offset = 30

  result &= "{\n"

  for word, fileIds in db.indexes:
    let namePart = &"  '{word}'"
    result &= namePart
    result &= ' '.repeat(max(0, offset - namePart.len)) & ": "

    result.add $collect(
      for id in fileIds:
        db.files[id]
    )
    result &= "\n"
  result &= "}"

when isMainModule:
  echo initInvertedIndex("/usr/share/awk")
