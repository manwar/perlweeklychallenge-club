#!/usr/local/bin/node

//
// Run as: node ch-1.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {console . log (eval (line))})

