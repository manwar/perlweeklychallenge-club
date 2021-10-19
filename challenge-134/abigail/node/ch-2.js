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
    let [n, m] = line . trim () . split (" ") . map (x => +x)
    let seen = {}
    for (let i = 1; i <= n; i ++) {
        for (let j = 1; j <= m; j ++) {
            seen [i * j] = 1
        }
    }
    console . log (Object . keys (seen) . length)
})
