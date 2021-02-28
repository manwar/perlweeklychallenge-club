#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

let RIGHT = 0
let UP    = 1
let LEFT  = 2
let DOWN  = 3

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => main (_))
;

let printf = require ('printf')


function main (_) {
    let elements = _ . split (/\s+/)

    //
    // Calculate the optimal height and width
    //
    let n      = elements . length
    let height = Math . floor (Math . sqrt (n))
    for (;n % height;) {
        height --
    }
    let width = n / height

    //
    // Initialize a matrix to fill in
    //
    let matrix    = Array ()
    for (i = 0; i < height; i ++) {
        matrix [i] = Array ()
    }

    //
    // Fill in the matrix, starting from the bottom left
    //
    let min_x     = 0
    let max_x     = height - 1
    let min_y     = 0
    let max_y     = width  - 1
    let x         = max_x
    let y         = min_y
    let direction = RIGHT

    elements . forEach (element => {
        matrix [x] [y] = element
        let turn = 0
        if (direction == RIGHT) {
            if   (y >= max_y) {turn = 1; x --; max_x --}
            else {y ++}
        }
        if (direction == UP) {
            if   (x <= min_y) {turn = 1; y --; max_y --}
            else {x --}
        }
        if (direction == LEFT) {
            if   (y <= min_y) {turn = 1; x ++; min_x ++}
            else {y --}
        }
        if (direction == DOWN) {
            if   (x >= max_x) {turn = 1; y ++; min_y ++}
            else {x ++}
        }

        if (turn) {
            direction ++
            direction %= 4
        }
    })

    //
    // Calculate the width of each column
    //
    let widths = Array ()
    for (y = 0; y < width; y ++) {
        let max = 0
        for (x = 0; x < height; x ++) {
            if (max < matrix [x] [y] . length) {
                max = matrix [x] [y] . length
            }
        }
        widths [y] = max
    }

    //
    // Print the matrix
    //
    matrix . forEach (row => {
        row . forEach ((element, y) => {
            let format = "%s%" + widths [y] + "s"
            printf (process . stdout, format, y ? " " : "", element)
        })
        process . stdout . write ("\n")
    })
}
