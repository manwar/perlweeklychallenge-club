#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

function count (target, this_fib, prev_fib) {
    if (!this_fib) {this_fib = 1}
    if (!prev_fib) {prev_fib = 1}
    return target <  this_fib ? 0
         : target == this_fib ? 1
         : count (target - this_fib, this_fib + prev_fib, this_fib) +
           count (target,            this_fib + prev_fib, this_fib)
}


  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => console . log (count (+line)))
