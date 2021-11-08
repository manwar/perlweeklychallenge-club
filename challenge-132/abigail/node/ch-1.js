#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

function int (x) {
    if (x < 0) {
        return Math . ceil  (x)
    }
    else {
        return Math . floor (x)
    }
}

function g2j (Y, M, D) {
    return (int ((1461 * (Y +    4800 + int ((M - 14) / 12))) /   4) +
            int ((367 * (M - 2 -   12 * int ((M - 14) / 12))) /  12) -
            int ((3 * int (((Y + 4900 + int ((M - 14) / 12))  / 100))) / 4) +
            D - 32075)
}

function j2g (J) {
    let e  = 4 * (J + 1401 +
                  int (int ((4 * J + 274277) / 146097) * 3 / 4) - 38) + 3
    let D =   int (((5 * (int ((e % 1461) / 4)) + 2) % 153) / 5) + 1
    let M = ((int  ((5 * (int ((e % 1461) / 4)) + 2) / 153) + 2) % 12) + 1
    let Y = int (e / 1461) - 4716 + int ((12 + 2 - M) / 12)
    return [Y, M, D]
}

//
// pad a number to a requested length
//
function pad (num, l) {
    let out = num
    while (out . length < l) {
        out = "0" + out
    }
    return (out)
}

//
// Pretty print the output, since node.js doesn't have sprintf(),
// and util.format just doesn't do it.
//
function pp (d1, d2) {
    let e1 = d1 . map (x => x . toString ())
    let e2 = d2 . map (x => x . toString ())
    console . log ("%s/%s/%s, %s/%s/%s",
                       pad (e1 [0], 4), pad (e1 [1], 2), pad (e1 [2], 2),
                       pad (e2 [0], 4), pad (e2 [1], 2), pad (e2 [2], 2))
}

let julian_today = g2j (2021, 9, 22)

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let [Y, M, D] = line . split ('/') . map (x => +x)
    let julian_then = g2j (Y, M, D)
    pp (j2g (2 * julian_then  - julian_today),
        j2g (2 * julian_today - julian_then))
})
