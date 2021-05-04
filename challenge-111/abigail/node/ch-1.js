#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

let MATRIX_SIZE = 5

//
// Read in all the numbers, both the matrix and the target numbers
//
let numbers = 
  require      ("fs")
. readFileSync (0)                     // Read all.
. toString     ()                      // Turn it into a string.
. match        (/-?[0-9]+/g)

//
// Populate the matrix
//
let matrix = {}
for (let i = 0; i < MATRIX_SIZE * MATRIX_SIZE; i ++) {
    matrix [numbers [i]] = 1
}

//
// Check the rest of the numbers whether they're present
// in the matrix.
//
for (let j = MATRIX_SIZE * MATRIX_SIZE; j < numbers . length; j ++) {
    console . log (matrix [numbers [j]] ? 1 : 0)
}

