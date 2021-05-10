#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

let cache = {0: 1, 1: 1}

function fib (n) {
    cache [n] = cache [n] || fib (n - 1) + fib (n - 2)
    return cache [n]
}

  require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => console . log (fib (+ _)))
