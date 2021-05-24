#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => {
    let numbers = _ . split (/\s+/) . map (_ => +_)
    let sum     = numbers . reduce ((acc, val) => acc + val)
    console . log (numbers . map (_ => sum - _) . join (" "))
})
