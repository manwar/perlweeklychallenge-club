#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

let cache = {}

function count (target, this_fib, prev_fib) {
    if (!this_fib) {this_fib = 1}
    if (!prev_fib) {prev_fib = 1}
    let key = target + ";" + this_fib
    if (!(key in cache)) {
        cache [key] = target <  this_fib ? 0
                    : target == this_fib ? 1
                    : count (target - this_fib, this_fib + prev_fib, this_fib) +
                      count (target,            this_fib + prev_fib, this_fib)
    }
    return cache [key]
}


  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => console . log (count (+line)))
