#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, strformat, tables, sets, random]

type
  WordGame = ref object
    points: Table[char, int]
    bag: CountTable[char]
    dict: HashSet[string]

proc draw*(game: var WordGame, n: Natural): seq[char] =
  for _ in 1..n:
    let notEmpty: seq[char] = block:
      var tmp: seq[char]
      for val, cnt in game.bag:
        if cnt > 0: tmp.add val
      tmp

    let choice = notEmpty[rand(notEmpty.low..notEmpty.high)]
    result.add choice
    game.bag.inc(choice, -1)

proc rate*(game: WordGame, word: string): int =
  for c in word:
    result += game.points[c]

proc spellBestWord*(game: WordGame, letters: seq[char]): string =
  let available = letters.toCountTable()
  var bestRating = 0

  for word in game.dict:
    block validWord:
      var available = available
      for c in word:
        if c in available:
          available.inc(c, -1)
        else:
          break validWord

      let rating = game.rate(word)
      if rating > bestRating:
        bestRating = rating
        result = word

proc loadDict(filename: string, maxLen = int.high): HashSet[string] =
  for word in lines filename:
    if word.len > maxLen: continue
    block onlyLetters:
      for c in word:
        if c notin Letters:
          break onlyLetters

      result.incl word.toLowerAscii

proc main =
  const
    MaxWordLength = 7
    Points = {
      'a': 1, 'g': 1, 'i': 1, 's': 1, 'u': 1, 'x': 1, 'z': 1,
      'e': 2, 'j': 2, 'l': 2, 'r': 2, 'v': 2, 'y': 2,
      'f': 3, 'd': 3, 'p': 3, 'w': 3,
      'b': 4, 'n': 4,
      't': 5, 'o': 5, 'h': 5, 'm': 5, 'c': 5,
      'k': 10, 'q': 10,
    }.toTable()
    Bag = toCountTable(
      "aaaaaaaagggiiiiisssssssuuuuuxxzzzzzeeeeeeeeejjjlllrrrvvvyyyyyfffdddpppppwwwwwbbbbbnnnntttttooohhhmmmmcccckkqq"
    )

  var
    game = WordGame(
      points: Points,
      bag: Bag,
      dict: loadDict("/usr/share/dict/words", MaxWordLength)
    )

  randomize()

  let
    letters = game.draw(MaxWordLength)
    bestWord = game.spellBestWord(letters)
    rating = game.rate(bestWord)

  echo &"The best word you can spell out of letters {letters} is '{bestWord}', with rating of {rating} points."

when isMainModule:
  main()
