#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => {
    if (_ . replace (/\s+/g,      "")             // Remove spaces
          . replace (/^\+/,       "00")           // Replace leading '+' with 00
          . replace (/^\([0-9][0-9]\)/, "0000")   // Replace leading '(NN)'
                                                  // with 0000
          . match   (/^[0-9]{14}$/)) {            // Match 14 digits
        console . log (_)
    }
})
