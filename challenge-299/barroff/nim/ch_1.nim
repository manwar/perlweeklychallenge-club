import std/[sugar, unittest]

from std/sequtils import filter
from std/strutils import split, startsWith

# run tests with following command:
# nim r ch_1.nim

func cw(word: string, words: openArray[string]): string =
  let
    starters = filter(words, x => startsWith(word, x))

  if len(starters) == 0:
    return word
  else:
    return starters[0]

proc replace_words(sentence: string, words: openArray[string]): string =
  let
    splitSentence = split(sentence, " ")

  result = cw(splitSentence[0], words)

  for i in splitSentence[1..high(splitSentence)]:
    result = result & " " & cw(i, words)

suite "replace words":
  test "the cattle was rattle by the battery":
    check(replace_words("the cattle was rattle by the battery", ["cat", "bat",
        "rat"]) == "the cat was rat by the bat")

  test "aab aac and cac bab":
    check(replace_words("aab aac and cac bab", ["a", "b", "c"]) == "a a a c b")

  test "the manager was hit by a biker":
    check(replace_words("the manager was hit by a biker", ["man", "bike"]) == "the man was hit by a bike")
