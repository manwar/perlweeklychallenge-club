#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[algorithm]

type
  Alphabet = array[26, char]
  Chaocipher* = object
    zenith: int
    left, right: Alphabet

proc permute(disk: var Chaocipher) =
  # permute left disk
  let tmp = disk.left[(disk.zenith + 1) mod 26]
  for i in disk.zenith + 1 .. disk.zenith + 12:
    disk.left[i mod 26] = disk.left[(i + 1) mod 26]
  disk.left[(disk.zenith + 13) mod 26] = tmp

  # permute right disk
  disk.right.rotateLeft(1)
  let tmp2 = disk.right[(disk.zenith + 2) mod 26]
  for i in disk.zenith + 2 .. disk.zenith + 12:
    disk.right[i mod 26] = disk.right[(i + 1) mod 26]
  disk.right[(disk.zenith + 13) mod 26] = tmp2

proc encipher*(plaintext: string, left, right: Alphabet): string =
  var disk = Chaocipher(left: left, right: right)
  for c in plaintext:
    disk.zenith = disk.right.find(c)
    result.add disk.left[disk.zenith]
    disk.permute()

proc decipher*(ciphertext: string, left, right: Alphabet): string =
  var disk = Chaocipher(left: left, right: right)
  for c in ciphertext:
    disk.zenith = disk.left.find(c)
    result.add disk.right[disk.zenith]
    disk.permute()

when isMainModule:
  import std/unittest

  const
    LeftAlphabet = [
      'b', 'f', 'v', 'g', 'u', 'h', 'w', 'j', 'k', 'n', 'c', 'p', 'e', 'd', 'q', 'r',
      's', 't', 'i', 'x', 'y', 'l', 'm', 'o', 'z', 'a',
    ]
    RightAlphabet = [
      'c', 'm', 'o', 'p', 'r', 't', 'u', 'v', 'j', 'x', 'a', 'y', 'z', 'n', 'b', 'q',
      'd', 's', 'e', 'f', 'g', 'h', 'l', 'w', 'i', 'k',
    ]
    Plaintext = "allgoodqquickbrownfoxesjumpoverlazydogtosavetheirpartyw"
    Ciphertext = "clytzpnzklddqgfbootysnepuagkiunkncrinrcvkjnhtoafqpdpncv"

  suite "Chaocipher":
    test "Encipher text":
      check Plaintext.encipher(LeftAlphabet, RightAlphabet) == Ciphertext
    test "Decipher text":
      check Ciphertext.decipher(LeftAlphabet, RightAlphabet) == Plaintext
