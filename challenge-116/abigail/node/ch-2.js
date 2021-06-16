#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => console . log (squares_sum_to_square (_)))
;


function squares_sum_to_square (line) {
    let sum_of_squares = 0
    line . split ('') . forEach (letter => {
        if ("0" <= letter && letter <= "9") {
            sum_of_squares += + letter * + letter
        }
    })
    let root = Math . floor (.5 + Math . sqrt (sum_of_squares))
    return (sum_of_squares == root * root ? 1 : 0)
}
