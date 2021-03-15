#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => make_hash (+ _))
;


//
// Working from the end of the required string backwards, we alternate
// placing a hash, and placing a number. We place them in an array @out,
// and at the end, print out said array in reverse order.
//
function make_hash (index) {
    let out = []
    let hash = false
    while (index > 0) {
        if (hash = !hash) {
            out . push ("#")
            index --
        }
        else {
            out . push (index + 1)
            index -=   (index + 1) . toString () . length
        }
    }
    console . log (out . reverse () . join (""))
}
