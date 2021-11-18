#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js
//

let BASE  = 10
let COUNT =  5

function is_long (number) {
    let seen = Array (number) . fill (0)
    let rest = 0
    for (let i = 2; i <= number; i ++) {
        rest = (rest * BASE + BASE - 1) % number
        if (seen [rest] == 1) {
            return 0
        }
        seen [rest] = 1
    }
    return 1
}

let number = 1
while (COUNT > 0) {
    number ++
    if (BASE % number == 0) {
        continue
    }
    if (is_long (number)) {
        console . log (number)
        COUNT --
    }
}
