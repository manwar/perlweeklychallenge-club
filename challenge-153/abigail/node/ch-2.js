#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
//

//
// Run as: node ch-2.js < input-file
//

let fac = [1]
for (let n = 1; n <= 9; n ++) {
    fac [n] = n * fac [n - 1]
}

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let num = +line
    let n   = num
    let sum = 0
    while (n > 0) {
        sum += fac [n % 10]
        n    = Math . floor (n / 10)
    }
    console . log (num == sum ? 1 : 0)
})
