#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[sequtils]

func makeMap(words: openArray[string]): seq[seq[int8]] =
  result = newSeq[seq[int8]](words.len)
  for i, current in words:
    for j, next in words:
      if i == j:
        continue
      if current[^1] == next[0]:
        result[i].add j.int8

func longestChains*(words: openArray[string]): seq[seq[string]] =
  let map = makeMap(words)
  var paths = newSeqOfCap[seq[int8]](128)
  var longest = newSeqOfCap[seq[int8]](1300)

  for id, exits in map:
    if exits.len > 0:
      paths.add @[id.int8]

  while paths.len > 0:
    let path = paths.pop()
    let last = path[^1]
    var endpoint = true

    for exit in map[last]:
      if exit notin path:
        paths.add path & exit
        endpoint = false

    if endpoint:
      if longest.len < 1 or path.len > longest[0].len:
        longest = @[path]
      elif path.len == longest[0].len:
        longest.add path

  longest.mapIt(it.mapIt(words[it]))

when isMainModule:
  import std/unittest

  const
    Names = [
      "audino", "bagon", "baltoy", "banette", "bidoof", "braviary", "bronzor",
      "carracosta", "charmeleon", "cresselia", "croagunk", "darmanitan", "deino",
      "emboar", "emolga", "exeggcute", "gabite", "girafarig", "gulpin", "haxorus",
      "heatmor", "heatran", "ivysaur", "jellicent", "jumpluff", "kangaskhan",
      "kricketune", "landorus", "ledyba", "loudred", "lumineon", "lunatone", "machamp",
      "magnezone", "mamoswine", "nosepass", "petilil", "pidgeotto", "pikachu", "pinsir",
      "poliwrath", "poochyena", "porygon2", "porygonz", "registeel", "relicanth",
      "remoraid", "rufflet", "sableye", "scolipede", "scrafty", "seaking", "sealeo",
      "silcoon", "simisear", "snivy", "snorlax", "spoink", "starly", "tirtouga",
      "trapinch", "treecko", "tyrogue", "vigoroth", "vulpix", "wailord", "wartortle",
      "whismur", "wingull", "yamask"
    ]
    Expected = @[
      "machamp", "pinsir", "rufflet", "trapinch", "heatmor", "remoraid", "darmanitan",
      "nosepass", "starly", "yamask", "kricketune", "exeggcute", "emboar",
      "relicanth", "haxorus", "simisear", "registeel", "landorus", "seaking",
      "girafarig", "gabite", "emolga", "audino"
    ]

  suite "Head to tail Pokémon names":
    test "longest chain is 23 pokemons: machamp -> audino":
      let longest = longestChains(Names)
      check longest.allIt(it.len == 23)
      check Expected in longest
