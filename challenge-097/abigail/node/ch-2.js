#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js -s SIZE < input-file
//

const NR_OF_LETTERS = 26

//
// Parse input
//
const argv = require ('yargs')
. option ('s', {
    type: 'number',
  })
. demandOption ('s')
. argv;

const size = argv . s

//
// Iterate over the input
//
require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => {
    let sum      = 0
    let sections = _ . length / size
    //
    // Iterate over the positions
    //
    for (let i = 0; i < size; i ++) {
        //
        // Count the number of zeros in a specific position
        //
        let zeros = 0
        for (let j = 0; j < sections; j ++) {
            let index = j * size + i;
            if  (_ . substring (index, index + 1) == "0") {
                zeros ++
            }
        }
        //
        // Calculate the ones
        //
        let ones = sections - zeros
        
        //
        // Add the minimum of the zeros and ones
        //
        sum += zeros < ones ? zeros : ones
    }
    console . log (sum)
})
;
