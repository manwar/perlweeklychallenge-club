#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

function steps (x, y, prefix) {
    if (x == 0 && y == 0) {
        console . log (prefix)
        return
    }
    if (x > 0) {
        steps (x - 1, y,     prefix + "R")
        steps (x - 1, y + 1, prefix + "L")
    }
    if (y > 0) {
        steps (x,     y - 1, prefix + "H")
    }
}

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', number => steps (+number, 0, ""))
