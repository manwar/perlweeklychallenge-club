#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js
//


let count          = 10
let nr_of_divisors =  8

for (let n = 1; count > 0; n ++) {
    let s = Math . floor (Math . sqrt (n))
    if (n == s * s) {
        continue
    }
    let c = 0
    for (let d = 1; d <= s && c <= nr_of_divisors; d ++) {
        if (n % d == 0) {
            c += 2
        }
    }
    if (c == nr_of_divisors) {
        console . log (n)
        count --
    }
}
