#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', (num) => {
    let number = "0";
    for (let i = 0; i < + num; i ++) {
        number = next_number (number)
    }
    console . log (number)
})


function next_number (prev_number) {
    //
    // Grab the trailing 3s (tail), its preceding number (num), and
    // anything before that (prefix).
    //
    let [match, prefix, num, tail] =
        ("0" + prev_number) . match (/^(.*)([012])(3*)$/)

    //
    // First, we take the prefix, and add (num + 1) to it,
    // then the tail, where we have replaced each 3 by a 1.
    // Then replace any '11' with '12' (we can only have 11s at the end).
    // Finally, remove any leading 0.
    //
    return (prefix + (+ num + 1) + (tail . replace (/3/g,  "1"))) .
                                           replace (/11/g, "12")  .
                                           replace (/^0/,  "")
}
