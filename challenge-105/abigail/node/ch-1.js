#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//
// Input will consist of lines; each line will have two numbers, N and k, N > 0,
// k > 0. For each line of input, we output a line with the Nth root of k.
//
// We're not doing any input validations; we're assuming it's correct.
//

require ('readline') . createInterface ({input: process . stdin})   
                     . on ('line', _ => {
    let [N, k] = _ . split (' ')
    console . log (k ** (1 / N))
})
;
