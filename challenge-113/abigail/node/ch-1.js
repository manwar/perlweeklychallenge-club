#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

let tens = [0, 0, 1, 2, 1, 0, 2, 6, 3, 8];

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => {
    let [N, D] = _ . split (/\s+/) . map (_ => +_)
    let D10 = D == 0 ? 100 : 10 * D
    if (N >= D10 || (N % (D == 0 ? 10 : D) == 0)) {
        console . log (1)
        return
    }
    for (let i = 1; i <= tens [D]; i ++) {
        let T = N - 10 * i - D
        if (T >= 0 && T % D == 0) {
            console . log (1)
            return
        }
    }
    console . log (0)
})
