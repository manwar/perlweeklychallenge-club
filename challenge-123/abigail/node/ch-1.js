#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

let ugly   = [1]
let next_2 =  0
let next_3 =  0
let next_5 =  0

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', n => {
    n =+ n
    while (ugly . length < n) {
        ugly . push (Math . min (2 * ugly [next_2], 
                                 3 * ugly [next_3],
                                 5 * ugly [next_5]))

        if (2 * ugly [next_2] <= ugly [ugly . length - 1]) {next_2 ++}
        if (3 * ugly [next_3] <= ugly [ugly . length - 1]) {next_3 ++}
        if (5 * ugly [next_5] <= ugly [ugly . length - 1]) {next_5 ++}
    }
    console . log (ugly [n - 1])
})
