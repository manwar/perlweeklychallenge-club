#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

let NR_OF_DIGITS = 10

  require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => {
    //
    // Parse the input: count the digits
    //
    let digits = []
    for (let i = 0; i < NR_OF_DIGITS; i ++) {
        digits [i] = 0
    }
    _ . split (/\s+/) . map (_ => {digits [+_] ++})

    //
    // Find the smallest even number
    //
    let last = -1;
    for (let i = 0; i < NR_OF_DIGITS && last < 0; i += 2) {
        if (digits [i] > 0) {
            last = i
            digits [i] --
        }
    }

    //
    // Skip if there are no even digits in the input
    //
    if (last < 0) {
        return
    }

    //
    // Create the output: print the remaining numbers from high to low
    //
    let out = ""
    for (let i = NR_OF_DIGITS - 1; i >= 0; i --) {
        for (let j = 0; j < digits [i]; j ++) {
            out = out + i . toString ()
        }
    }
    console . log (out + last . toString ())
})
