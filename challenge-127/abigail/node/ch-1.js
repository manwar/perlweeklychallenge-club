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
    let seen = {}
    let out  = 1
    line . split (/[ ;]+/) . forEach (n => {
        if (n in seen) {
            out = 0
        }
        seen [n] = 1
    })
    console . log (out)
})

