#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
//

//
// Run as: node ch-2.js
//

let primes = [2, 3, 5, 7, 11, 13, 17, 19];
for (let n = 1; n <= 500; n ++) {
    let has_square = false
    primes . forEach (p => {
        if (n % (p * p) == 0) {
            has_square = true
        }
    })
    if (!has_square) {
        process . stdout . write (n . toString () + " ")
    }
}
process . stdout . write ("\n")
