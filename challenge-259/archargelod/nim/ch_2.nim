#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, parseutils, tables]

type
  ValueKind = enum
    StringValue
    IntValue

  Value = object
    case kind: ValueKind
    of StringValue:
      strval: string
    of IntValue:
      intval: int

  Struct = object
    id: string
    fields: OrderedTable[string, Value] # assuming order is important

proc `==`(v: Value, s: string): bool =
  v.kind == StringValue and v.strval == s

proc `==`(v: Value, i: SomeInteger): bool =
  v.kind == IntValue and v.intval == i

template consume(input: string, amount: int = 1) =
  index += amount
  if index > input.high:
    raise newException(ValueError, "Unexpected end.")

template consume(input, token: string) =
  for i, c in token:
    if index + i > input.high or c != input[index + i]:
      raise newException(ValueError, "Expected: " & token)
  index += token.len

proc parseStruct(input: string): Struct =
  var index = 0
  input.consume("{%")

  # parse ID
  index += input.skipWhitespace(index)
  let tokenLength = input.skipWhile(Letters + Digits + {'_'}, index)
  result.id = input[index ..< index + tokenLength]
  index += tokenLength

  index += input.skipWhitespace(index)

  # parse fields
  while index < input.len:
    if input[index] notin Letters + Digits + {'_'}:
      break

    let fieldNameLength = input.skipWhile(Letters + Digits + {'_'}, index)
    if index + fieldNameLength > input.high:
      raise newException(ValueError, "Unexpected end.")

    let fieldName = input[index ..< index + fieldNameLength]
    input.consume fieldNameLength

    input.consume "="

    if input[index] == '"':
      input.consume()
      var strVal = ""
      while true:
        if input[index] == '\\':
          input.consume()
        elif input[index] == '"':
          break
        strVal &= input[index]
        input.consume()

      result.fields[fieldName] = Value(kind: StringValue, strval: strVal)
      input.consume "\""
    else:
      let intLength = input.skipWhile(Digits, index)
      let intVal = parseInt(input[index ..< index + intLength])
      result.fields[fieldName] = Value(kind: IntValue, intval: intVal)
      input.consume intLength

    input.consume input.skipWhitespace(index)
  input.consume "%}"

when isMainModule:
  import std/unittest

  const
    Test = """{%  youtube title="Title \\ \"quoted\" done" some_field=12 %}"""

  suite "Line Parser":
    test "Example 1":
      let struct = parseStruct(Test)
      check struct.id == "youtube"
      check struct.fields["title"] == "Title \\ \"quoted\" done"
      check struct.fields["some_field"] == 12
