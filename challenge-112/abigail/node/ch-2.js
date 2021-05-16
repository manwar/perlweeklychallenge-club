#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

let SQRT5 = Math . sqrt (5)
let PHI   = (1 + SQRT5) / 2

  require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => console . log (
    Math . round (Math . pow (PHI, +_ + 1) / SQRT5)
))
