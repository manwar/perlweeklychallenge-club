#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

let w = [1, 3, 1, 7, 3, 9, 1]

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    line = line . trim ()
    if (line . length != 7 ||
        line . match (/[^0-9BCDFGHJKLMNPQRSTVWXYZ]/) ||
        line . match (/[^0-9]$/)) {
        console . log (0)
    }
    else {
        let check = 0
        for (let i = 0; i < 7; i ++) {
            let val = line . charCodeAt (i)
            val   -= (val <= "9" . charCodeAt (0) ? "0" : "A") . charCodeAt (0)
            check += w [i] * val
        }
        console . log (check % 10 == 0 ? 1 : 0)
    }
})
