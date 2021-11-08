#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    [m, n] = line . split (" ") . map (_ => +_)
    console . log (m ^ (1 << -- n))
})
