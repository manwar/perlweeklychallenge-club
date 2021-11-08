#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', num => {
    console . log (Math . floor (Math . exp (Math . log (+num) / 2)))
})
