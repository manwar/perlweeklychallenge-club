#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js -s TIMES < input-file
//

const NR_OF_LETTERS = 26
const ORD_A         = "A" . charCodeAt (0)

//
// Parse input
//
const argv = require ('yargs')
. option ('s', {
    type: 'number',
  })
. demandOption ('s')
. argv;

const shift = argv . s

//
// Shift capital letters, by a given amount.
//
function shift_char (char, shift) {
    if (char . match (/[A-Z]/)) {
        let n = char . charCodeAt (0) - (shift % NR_OF_LETTERS)
        if (n < ORD_A) {
           n = n + NR_OF_LETTERS
        }
        return String . fromCharCode (n)
    }
    else {
        return char
    }
}


//
// Iterate over the input, and shift characters
//
require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => console . log (_ . split ("")
                                    . map   (_ => shift_char (_, shift))
                                    . join  ("")))
;
