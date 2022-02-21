#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
//

//
// Run as: node ch-1.js
//

let sum = 1
let fac = 1

process . stdout . write (sum . toString ())

for (let n = 1; n <= 9; n ++) {
    process . stdout . write (" " + (sum += fac *= n) . toString ())
}

process . stdout . write ("\n")
