#!/opt/homebrew/bin/node

function are_anagrams (str1, str2) {
    return str1 . split ("") . toSorted () . join ("") ==
           str2 . split ("") . toSorted () . join ("")
}

function can_scramble (input, target) {
    if (input == target) {
        return true
    }

    if (input . length != target . length) {
        return false
    }

    if (!are_anagrams (input, target)) {
        return false
    }

    for (var l = 1; l < input . length; l ++) {
        var m = input . length - l
        if (can_scramble (input . substr (0, l), target . substr (0, l)) &&
            can_scramble (input . substr (l)   , target . substr (l))    ||
            can_scramble (input . substr (l),    target . substr (0, m)) &&
            can_scramble (input . substr (0, l), target . substr (m))) {
            return true
        }
    }
    return false
}
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
      [input, target] = line . split (" ")

      console . log (can_scramble (input, target))
  })
