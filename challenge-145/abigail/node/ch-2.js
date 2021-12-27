#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let palindromes = {}
    let out         = ""
    line = line . trim ()
    for (let i = 0; i < line . length; i ++) {
        for (let j = i; j < line . length; j ++) {
            let string = line . substring (i, j + 1)
            if (string == string . split ("") . reverse () . join ("")) {
                if (!(string in palindromes)) {
                    out = out + string + " "
                    palindromes [string] = 1
                }
            }
        }
    }
    console . log (out)
})
