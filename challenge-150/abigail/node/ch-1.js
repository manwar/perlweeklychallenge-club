#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
//

//
// Run as: node ch-1.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let [fib_prev, fib_last] = line . trim () . split (" ")
    while (fib_last . length < 51) {
        let fib_tmp = fib_last
        fib_last    = fib_prev + fib_last
        fib_prev    = fib_tmp
    }
    console . log (fib_last [50])
})
