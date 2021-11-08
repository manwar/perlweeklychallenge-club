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
    console . log ( (+num & ~0xFF)
                  | (+num &  0x0F) << 4
                  | (+num &  0xF0) >> 4)
})
