#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1a.js
//


let cache = [0, 1]
let max   = 50

function fusc (n) {
    if (cache [n] === undefined) {
        cache [n] = n % 2 == 1 ? fusc ((n - 1) / 2) + fusc ((n + 1) / 2)
                               : fusc  (n      / 2)
    }
    return cache [n]
}

for (i = 0; i < max; i ++) {
    if (i > 0) {
        process . stdout . write (" ")
    }
    process . stdout . write (fusc (i) . toString ())
}

process . stdout . write ("\n")
