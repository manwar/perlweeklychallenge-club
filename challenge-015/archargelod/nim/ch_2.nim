#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, math]

type cipherMode = enum
  Encode
  Decode

proc alphaOrd(c: char): int =
  c.ord - 'a'.ord

proc rot(c: sink char, shift: int): char =
  char('a'.ord + euclMod(c.alphaOrd + shift, 26))

proc vigenereCipher(plaintext: var string, key: string, mode = Encode) =
  for i, c in plaintext:
    if c notin Letters:
      continue

    let key = block:
      let tmp = key[i mod key.len].toLowerAscii.alphaOrd
      if mode == Decode: -tmp else: tmp

    plaintext[i] = c.toLowerAscii.rot(key)

proc encode*(plaintext: var string, key: string) =
  vigenereCipher(plaintext, key, Encode)

proc decode*(plaintext: var string, key: string) =
  vigenereCipher(plaintext, key, Decode)


when isMainModule:
  import std/unittest

  const
    Plaintext = "attacking tonight"
    Key = "OCULORHINOLARINGOLOGY"
    ExpectedEncoded = "ovnlqbpvt eoeqtnh"

  suite "Vigenère cipher":
    var text = Plaintext

    test "encode sample text":
      text.encode(Key)
      check text == ExpectedEncoded

    test "decode sample text":
      text.decode(Key)
      check text == Plaintext
