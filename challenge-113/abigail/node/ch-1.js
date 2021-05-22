#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

//     
// For a description of the algorithm, and the proof why this is correct:
// https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-113-1.html
//  

let gcds = [0, 1, 2, 1, 2, 5, 2, 1, 2, 1];

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => {
    let [N, D] = _ . split (/\s+/) . map (_ => +_)
    if (D == 0) {
        console . log (N >= 100 || N % 10 == 0 ? 1 : 0)
        return
    }
    if (N >= D * 10) {
        console . log (1)
        return
    }
    for (let i = 0; i < D / gcds [D]; i ++) {
        let T = N - 10 * i - D
        if (T >= 0 && T % D == 0) {
            console . log (1)
            return
        }
    }
    console . log (0)
})
