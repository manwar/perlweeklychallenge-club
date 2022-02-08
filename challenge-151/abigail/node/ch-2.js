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
    let houses = line . trim () . split (/ +/) . map (n => +n)
    let best   = []
    let size   = houses . length
    best [size + 0] = 0
    best [size + 1] = 0
    for (let i = size - 1; i >= 2; i --) {
        best [i] = Math . max (houses [i] + best [i + 2], best [i + 1])
    }
    console . log (houses [0] + best [2])
})
