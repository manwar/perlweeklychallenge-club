#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js {-f | -t} < input-file
//
//   -f: Translate from base 35 to base 10
//   -t: Translate to base 35 from base 10
//

let BASE = 35

//
// Parse options using the yargs module
//
const argv = require ('yargs')
. option ('from_base', {
    alias: 'f',
    type:  'boolean',
})
. option ('to_base', {
    alias: 't',
    type:  'boolean',
})
. argv;

//
// Check options
//
if ((argv . to_base ? 1 : 0) + (argv . from_base ? 1 : 0) != 1) {
    console . log ("Requires exactly one of '-f' or '-t'")
    process . exit (1)
}

//
// Set up digits, mapping base-10 numbers to base-35 digits, and vice versa
//
let digits = {};
for (let i = 0; i < 10; i ++) {
    digits [i] = i
}
for (let i = 10; i < BASE; i ++) {
    let char = String . fromCharCode (65 + i - 10)
    digits [char] = i
    digits [i] = char
}

//
// Translate to base 35
//
function to_base (number) {
    let out = "";
    while (number) {
        let n = number % BASE
        out = digits [n] + out
        number = Math . floor (number / BASE)
    }
    return out
}

//
// Translate from base 35
//
function from_base (base) {
    let out = 0
    base . split ('') . forEach (c => {
        out = BASE * out + digits [c]
    })
    return out
}


//
// Iterate over the input, call either to_base or from_base for each
// line, depending on the -f or -t parameter.
//
require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => console . log (argv . to_base ? to_base (+ _)
                                                 : from_base (_ . trim ())))
;
