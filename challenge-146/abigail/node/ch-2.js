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
    let [a, b] = line . trim () . split ("/") . map (x => +x)
    for (let i = 1; i <= 2; i ++) {
        if (a < b) {
            b -= a
        }
        else {
            a -= b
        }
        if (a == 0 || b == 0) {
            break
        }
        process . stdout . write (a . toString ())
        process . stdout . write ("/")
        process . stdout . write (b . toString ())
        process . stdout . write (" ")
    }
    process . stdout . write ("\n")
})
