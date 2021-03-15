#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', max => {
    for (let base2 = 1; base2 <= max; base2 *= 2) {
        for (let base3 = base2; base3 <= max; base3 *= 3) {
            for (let base5 = base3; base5 <= max; base5 *= 5) {
                console . log (base5)
            }
        }
    }
});
