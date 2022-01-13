#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

function substrings (n, m, prefix, max) {
    if (n . length == 0) {
        return prefix > -1   &&
               prefix < max  &&
               prefix % m == 0 ? 1 : 0
    }

    let fc       = n . substr (0, 1)
    let tail     = n . substr (1)
    let n_prefix = 10 * (prefix == -1 ? 0 : prefix) + + n . substr (0, 1)

    return substrings (tail, m, n_prefix, max) +
           substrings (tail, m, prefix,   max);
}

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let [n, m] = line . split (" ")
    console . log (substrings (n, +m, -1, +n))
})

