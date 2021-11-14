#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

function can_split (target, number) {
    if (target >  number || target < 0) {return false}
    if (target == number)               {return true}

    let pow_10 = 10

    while (pow_10 <= number) {
        if (can_split (target - (number % pow_10),
                   Math . floor (number / pow_10))) {
            return true
        }
        pow_10 *= 10
    }

    return false
}


  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', number => {
    console . log (number > 1 && can_split
                  (Math . trunc (Math . sqrt (number)), number) ? 1 : 0)
})
