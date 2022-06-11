#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
//

//
// Run as: node ch-2.js
//


let COUNT = 5
let A     = 0
let B     = 1
let C     = 2
let SUM   = 3
let out   = []
for (let i = 0; i < COUNT; i ++) {
    out . push ([999999, 999999, 999999, 999999 * 3])
}

let max_index = 0

for (let k = 0; 3 * k + 2 <= out [max_index] [SUM]; k ++) {
    let a  = 3 * k + 2
    let f1 =     k + 1
    let f2 = 8 * k + 5

    //
    // Find divisors of f1
    //
    let d1 = []
    for (let i = 1; i * i <= f1; i ++) {
        if (f1 % i == 0) {
            d1 . push (i)
            if (i != f1 / i) {
                d1 . push (f1 / i)
            }
        }
    }

    //
    // Find square divisors of f2
    //
    let d2 = []
    for (let i = 1; i * i <= f2; i ++) {
        if (f2 % i == 0) {
            let s1 = Math . floor (Math . sqrt (i))
            let s2 = Math . floor (Math . sqrt (f2 / i))
            if (s1 * s1 == i) {
                d2 . push (s1)
            }
            if (s2 * s2 == f2 / i && s1 != s2) {
                d2 . push (s2)
            }
        }
    }

    for (let i = 0; i < d1 . length; i ++) {
        for (let j = 0; j < d2 . length; j ++) {
            let b = d1 [i] * d2 [j]
            let c = f1 * f1 * f2 / (b * b)
            if (a + b + c < out [max_index] [SUM]) {
                let seen = false
                for (let l = 0; l < COUNT; l ++) {
                    if (out [l] [A] == a && out [l] [B] == b) {
                        seen = true
                    }
                }
                if (seen) {
                    break
                }

                out [max_index] [A]   = a
                out [max_index] [B]   = b
                out [max_index] [C]   = c
                out [max_index] [SUM] = a + b + c

                //
                // Find new max_index
                //

                max_index = 0
                let max_sum = out [max_index] [SUM]
                for (let m = 1; m < COUNT; m ++) {
                    if (max_sum < out [m] [SUM]) {
                        max_index = m
                        max_sum   = out [m] [SUM]
                    }
                }
            }
        }
    }
}

const printf = require ('printf')

for (let i = 0; i < COUNT; i ++) {
    printf (process . stdout,
            "%d %d %d\n", out [i] [A], out [i] [B], out [i] [C])
}
