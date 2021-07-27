#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', n => {
    let scores = []
    scores [0] = []
    scores [1] = []
    scores [2] = [""]

    n =+ n
    for (i = 3; i < n + 3; i ++) {
        scores [i] = []
        for (j = 1; j <= 3; j ++) {
            scores [i] . push (... scores [i - j] . map (s => j + " " + s))
        }
    }

    scores [n + 2] . forEach (s => console . log (s))
})

