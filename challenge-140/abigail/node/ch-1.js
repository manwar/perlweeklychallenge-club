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
    let [a, b] = line . trim () . split (" ");
    console . log ((parseInt (a, 2) + parseInt (b, 2)) . toString (2))
})

