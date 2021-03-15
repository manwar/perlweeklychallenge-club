#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => triangle (+_))
;


function triangle (rows) {
    //
    // Create and print the 0th row
    //
    let row = [1]
    process . stdout . write ("1\n")
    for (let r = 1; r <= rows; r ++) {
        //
        // Calculate a new row
        //
        let new_row = []
        for (i = 0; i <= r; i ++) {
            new_row [i] = (i == 0 ? 0 : row [i - 1]) +
                          (i == r ? 0 : row [i]);
            if (i > 0) {
                process . stdout . write (" ")
            }
            process . stdout . write ("" + new_row [i])
        }
        process . stdout . write ("\n")

        //
        // New row becomes current row
        //
        row = new_row
    }
}
