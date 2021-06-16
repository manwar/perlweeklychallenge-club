#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

function steps (x, y, path) {
    if (x == 0 && y == 0) {
        console . log (path)
        return
    }
    if (x > 0) {
        steps (x - 1, y,     path + "R")
        steps (x - 1, y + 1, path + "L")
    }
    if (y > 0) {
        steps (x,     y - 1, path + "H")
    }
}

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', number => steps (+number, 0, ""))
