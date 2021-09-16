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
    let numbers = {}
    let input = [... line . matchAll (/[1-9][0-9]*/g)] . map (_ => + _ [0])
    input . forEach (n => {
        if (!numbers [n]) {
            numbers [n] = 1
        }
        else {
            numbers [n] ++
        }
    })
    for (let n in numbers) {
        if (numbers [n] % 2 == 1) {
            console . log (n)
        }
    }
})
