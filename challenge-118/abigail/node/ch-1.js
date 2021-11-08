#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', (line) => {
    let bin = (+line) . toString (2)
    console . log (bin == bin . split ("") . reverse () . join ("") ? 1 : 0)
})
