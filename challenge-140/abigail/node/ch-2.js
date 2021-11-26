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
    let [i, j, k] = line . split (" ") . map (_ => +_)
    let n = 0
    while (k > 0) {
        n ++
        let s = Math . floor (Math . sqrt (n))
        for (let d = 1; d <= s && k > 0; d ++) {
            if (n % d == 0) {
                if (d <= i && n / d <= j) {k --}
                if (d <= j && n / d <= i) {k --}
                if (n == d * d)           {k ++}
            }
        }
    }
    console . log (n)
})
