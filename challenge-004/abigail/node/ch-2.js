#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js -f filename < input-file
//

const fs       = require ('fs')
const readline = require ('readline')
const yargs    = require ('yargs')

//
// Parse options using the yargs module
//
const argv = yargs . option ('file', {
                         alias: 'f',
                         type:  'string',
                     })
                   . argv;

let filename = argv . file;

//
// Extract the words from the file 'filename' which can be
// made with the letters from 'letters'.
//
function find_words (filename, letters) {
    letters = letters . toLowerCase ()
                      . split ("")
    readline . createInterface ({input: fs . createReadStream (filename)})
             . on ('line', word => {
                   let copy = word . toLowerCase ()
                   letters . forEach (l => {
                       copy = copy . replace (l, "")
                   })
                   if (copy == "") {
                       console . log (word)
                   }
             })
}

readline . createInterface ({input: process . stdin})   
         . on ('line', letters => find_words (filename, letters))
