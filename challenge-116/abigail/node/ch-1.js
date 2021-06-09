#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

  require         ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => main (line))

function make_chain (string, start) {
    if (string == start) {
        return [start]
    }
    if (0 == string . indexOf (start)) {
        let tail = string . substr (start . length)
        let result = make_chain (tail, (+ start + 1) . toString ()) ||
                     make_chain (tail, (+ start - 1) . toString ())
        if (result) {
            result . unshift (start)
            return result
        }
    }
    return null
}


function main (line) {
    for (let i = 1; i <= line . length; i ++) {
        let start  = line . substr (0, i)
        let result = make_chain (line, start)
        if (result) {
            console . log (result . join (","))
            break
        }
    }
}
