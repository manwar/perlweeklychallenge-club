#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
//

//
// Run as: node ch-1.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let numbers = line . trim () . split (/ +/) . map (n => +n)
    let minsum  = 0
    let n       = 1
    while (numbers . length) {
        minsum += Math . min (... numbers . splice (0, n ++))
    }
    console . log (minsum)
})
