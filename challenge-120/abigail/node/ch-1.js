#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', (num) => {
    console . log ( (+num & 0x55) << 1
                  | (+num & 0xAA) >> 1)
})
