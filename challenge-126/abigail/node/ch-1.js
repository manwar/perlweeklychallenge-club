#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', n => {
    result = 0
    seen_one = 0
    n . trim () . split ('') . forEach (digit => {
        result *= 9
        if (seen_one) {result += 8}
        else {
            if (digit == "1") {seen_one = 1}
            else {
                if (digit != "0") {result += +digit - 1}
            }
        }
    })
    console . log (result)
})
