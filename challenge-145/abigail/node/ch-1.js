#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

let fs      = require ("fs")
let [a, b]  = fs . readFileSync (0) . toString () . trim () . split ("\n") .
              map (line => (line . split (" ")) . map (n => +n))

console . log (a . reduce ((sum, n, i) => {return sum + a [i] * b [i]}, 0))
