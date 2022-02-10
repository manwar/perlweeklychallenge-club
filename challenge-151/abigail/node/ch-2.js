#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
//

//
// Run as: node ch-2.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let h = line . trim () . split (/ +/) . map (n => +n)
    h [h . length] = 0
    h [h . length] = 0
    for (let i = h . length - 3; i >= 2; i --) {
        h [i] = Math . max (h [i] + h [i + 2], h [i + 1])
    }
    console . log (h [0] + h [2])
})
