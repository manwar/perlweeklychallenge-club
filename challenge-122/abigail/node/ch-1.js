#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

let s = 0
let c = 0

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', n => {console . log ((s +=+ n) / ++ c)})
