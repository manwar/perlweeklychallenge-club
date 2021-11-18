#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    console . log (line . match (/[0-9]+/gi) . reduce ((sorted, _, i, list) => {
        if (i > 0 && list [i - 1] > list [i]) {sorted = 0}
        return sorted},
        1)
    )
})

