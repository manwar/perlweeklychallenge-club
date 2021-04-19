#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js
//

let COUNT   = 10
let PLAIN   =  0
let COMPUTE =  1

let type = PLAIN

if (process . argv . length > 2 &&
    process . argv [2] == "compute") {
    type = COMPUTE
}

if (type == PLAIN) {
    console . log ("1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147")
}

if (type == COMPUTE) {
    let bell = [[ 1 ]]
    let x
    for (x = 1; x < COUNT - 1; x ++) {
        bell [x] = [bell [x - 1] [x - 1]]
        let y
        for (y = 1; y <= x; y ++) {
            bell [x] [y] = bell [x] [y - 1] + bell [x - 1] [y - 1]
        }
    }

    process . stdout . write ("1")
    for (x = 0; x < COUNT - 1; x ++) {
        process . stdout . write (", " + bell [x] [x] . toString ())
    }
    process . stdout . write ("\n")
}
