#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/strutils
import pkg/nimcrypto/sha2 ## `$ nimble install nimcrypto`

const
  DecodedLength = 25
  ChecksumLength = 4

func base58Decode(input: string): array[DecodedLength, byte] =
  ## Taken from https://rosettacode.org/wiki/Bitcoin/address_validation#Nim
  ## Tried to implement this myself, but failed to find easy to understand algorithm.
  const Base = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"

  for c in input:
    var n = Base.find(c)
    if n < 0:
      raise newException(ValueError, "invalid character: " & c)

    for i in countdown(result.high, 0):
      n += Base.len * result[i].int
      result[i] = byte(n and 255)
      n = n div 256

    if n != 0:
      raise newException(ValueError, "decoded address is too long")

func validBtcChecksum(address: openarray[byte]): bool =
  let digest1 = sha256.digest(address.toOpenArray(0, address.high - ChecksumLength)).data
  let digest2 = sha256.digest(digest1).data
  digest2[0 ..< ChecksumLength] == address[^ChecksumLength ..^ 1]

func isValidBTCAddress(address: string): bool =
  address.len >= 26 and address[0] in {'1', '3'} and
    validBtcChecksum(address.base58Decode())

when isMainModule:
  import std/unittest

  const
    Valid = ["1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2", "3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy"]
    Invalid = ["3J98t1WpEZ73CNmQviecrnyiWrDEADBEEF"]

  suite "Validate bitcoin address":
    test "Example 1":
      check isValidBTCAddress Valid[0]
    test "Example 2":
      check isValidBTCAddress Valid[1]
    test "Invalid address":
      check not isValidBtcAddress Invalid[0]
