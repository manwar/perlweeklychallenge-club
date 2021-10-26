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
    line = line . replace (/^[-+]/, '') . trim ()
    if (line . match (/[^0-9]/)) {
        console . log ("not an integer")
    }
    else {
        if (line . length % 2 == 0) {
            console . log ("even number of digits")
        }
        else {
            if (line . length < 3) {
                console . log ("too short")
            }
            else {
                console . log (line . substr ((line . length - 3) / 2, 3))
            }
        }
    }
})

