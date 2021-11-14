#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

function reverse (num) {
    let rev = 0
    while (num > 0) {
        rev *= 10
        rev += num % 10
        num  = Math . floor (num / 10)
    }
    return (rev)
}

function ly (n) {
    return n >= 10000000    ? 1
         : n == reverse (n) ? 0
         : ly (n + reverse (n))
}

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', num => console . log (ly (+num)))

