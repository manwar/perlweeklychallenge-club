#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

let SUM_15 = 120
let sum = 0

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let [num] = line . split (/,/)
    sum +=+ num
})
. on              ('close', () => console . log (SUM_15 - sum))
