#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

require ('readline')
. createInterface ({input: process . stdin})
. on ('line', _ =>
       console . log (_ . trim    ()        // Remove leading/trailing spaces
                        . split   (/\s+/)   // Split on white space
                        . reverse ()        // Reverse the words
                        . join    (" ")))   // And join them again.
;
