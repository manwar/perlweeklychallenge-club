#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
//

//
// Run as: node ch-1.js < input-file
//

function digit_sum (number) {
    let sum  =  0
    let base = 10
    while (number > 0) {
        sum   += number % base
        number = Math . floor (number / base)   
    }
    return sum
}

let fib        = {}
let fib_prev   = 0
let fib_last   = 1
fib [fib_prev] = true
fib [fib_last] = true

function is_fib (n) {
    while (fib_last < n) {
        let t          = fib_last
        fib_last      += fib_prev
        fib_prev       = t
        fib [fib_last] = true
    }
    return (fib [n])
}

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', n => {
    n = +n
    for (let k = 0; n > 0; k ++) {
        if (is_fib (digit_sum (k))) {
            process . stdout . write (k . toString () + " ")
            n --
        }
    }
    process . stdout . write ("\n")
})
