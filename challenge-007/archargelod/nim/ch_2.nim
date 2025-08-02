#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[tables, deques]

type Node = ref object
  word: string
  neighbours: seq[Node]

func hammingDist(s1, s2: string): int =
  if s1.len != s2.len:
    raise newException(ValueError, "Both words should be the same length.")
  for i, c in s1:
    if c != s2[i]:
      inc result

func shortestPath(start: Node, finish: string): seq[string] =
  var paths: Deque[seq[Node]]
  paths.addFirst @[start]

  while paths.len > 0:
    var
      path = paths.popLast()
      last = path[^1]

    if last.word == finish:
      for n in path:
        result.add n.word
      return result

    for neighbour in last.neighbours:
      if neighbour notin path:
        paths.addLast path & neighbour

  raise newException(ValueError, "No path exists.")

func makeMap(words: sink seq[string], start: string): Node =
  var nodes: Table[string, Node]

  for word in words:
    nodes[word] = Node(word: word)

  for i, word in words:
    for j, word2 in words:
      if i == j:
        continue
      if hammingDist(word, word2) == 1:
        nodes[word].neighbours.add nodes[word2]

  nodes[start]

proc makeMap(dictFile, start: string): Node =
  var words: seq[string]
  for word in lines dictFile:
    words.add word
  makeMap(words, start)

proc findShortestWordLadder*(
    start, finish: string, dict: string | seq[string]
  ): seq[string] =
  ## dict should be the path to dictionary file
  ## with words separated by newlines or `seq[string]` of these words
  ## dictionary words should be the same length
  ## returns empty `seq[string]` on error.
  try:
    var startNode = makeMap(dict, start)
    result = startNode.shortestPath(finish)
  except ValueError:
    return @[]

when isMainModule:
  import std/unittest

  const
    Words = @["cold", "cord", "core", "care", "card", "ward", "warm"]
    WrongLengthWords = @["cold", "cord", "core", "caress"]
    NoPathsWords = @["cold", "rule", "core", "bear"]
    Start = "cold"
    Finish = "warm"
    Expected = @["cold", "cord", "card", "ward", "warm"]
    Empty: seq[string] = @[]

  suite "Word Ladders":
    test "cold -> warm":
      check findShortestWordLadder(Start, Finish, Words) == Expected
    test "wrong length":
      check findShortestWordLadder(Start, Finish, WrongLengthWords) == Empty
    test "no possible paths":
      check findShortestWordLadder(Start, Finish, NoPathsWords) == Empty
