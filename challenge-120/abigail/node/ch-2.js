#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

let DIFF_PER_MINUTE =  11
let MIN_PER_HOUR    =  60
let FULL_CIRCLE     = 720

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let [hours, minutes] = line . trim () . split (":")
    angle = (DIFF_PER_MINUTE * (+hours * MIN_PER_HOUR + +minutes)) %
                                         FULL_CIRCLE
    if (2 * angle >= FULL_CIRCLE) {
        angle = FULL_CIRCLE - angle
    }

    console . log (angle / 2)
})
