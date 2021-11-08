#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => main (+ line))

function introot (square) {
    return (Math . floor (.4 + Math . sqrt (square)))
}

function main (n) {
    if (n <= 2) {
        console . log (-1)
        return
    }

    let n_sq = n * n
    let c    = n + 1
    let c_sq = n_sq + 2 * n + 1
    while (2 * c - 1 <= n_sq) {
        let b_sq = c_sq - n_sq
        let b    = introot (b_sq)

        if (b_sq == b * b) {
            console . log (n + " " + b + " " + c)
        }

        c_sq += 2 * c ++ + 1
    }

    let max_a = Math . floor (n / Math . sqrt (2))
    for (let a = 3; a <= max_a; a ++) {
        let b_sq = n_sq - a * a
        let b    = introot (b_sq)
        if (b_sq == b * b) {
            console . log (a + " " + b + " " + n)
        }
    }
}
