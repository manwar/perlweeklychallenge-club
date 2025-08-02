#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

# we can add C code directly to Nim source file with emit pragma
{.emit: """
  char* hello_world() {
    return "Hello, World!";
  }
""".}

# this is a thin wrapper over C function with a new name
proc hello_C: cstring {.importc: "hello_world".}

# https://www.gnu.org/software/libc/manual/html_node/Obfuscating-Data.html
proc memfrob(mem: pointer, length: csize_t): pointer {.importc.}

# a proper wrapper
proc obfuscate*[T: char | byte](arr: var openarray[T]) =
  ## Reversibly obfuscates data. Each byte is bitwise xor-ed
  ## with the binary pattern 00101010 (hexadecimal 0x2A)
  discard memfrob(arr.addr, csize_t(arr.len))

when isMainModule:
  import std/unittest

  const
    Greeting = "Hello, World!"
    Plain = "abcdefgh"
    Obfuscated = "KHINOLMB"

  suite "Calling C functions":
    test "Custom C function":
      check hello_C() == Greeting
    test "GNU libc (glibc) function":
      var a = Plain
      a.obfuscate()
      check a == Obfuscated
      a.obfuscate()
      check a == Plain
