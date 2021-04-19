#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js [plain | compute]
//

let PLAIN   =  0
let COMPUTE =  1

let COUNT   = 20

function divisor_sum (n) {
    let sum = 0
    for (let i = 2; i < n; i ++) {
        if (n % i == 0) {
            sum += i
        }
    }
    return (sum)
}

let type = PLAIN
if (process . argv . length > 2 &&
    process . argv [2] == "compute") {
    type = COMPUTE
}

if (type == PLAIN) {
    console . log ("0, 0, 0, 2, 0, 5, 0, 6, 3, 7, " +
                   "0, 15, 0, 9, 8, 14, 0, 20, 0, 21")
}

if (type == COMPUTE) {
    for (let i = 1; i <= COUNT; i ++) {
        if (i > 1) {
            process . stdout . write (", ")
        }
        process . stdout . write (divisor_sum (i) . toString ())
    }
    process . stdout . write ("\n")
}
