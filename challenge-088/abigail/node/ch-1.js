//
// Challenge
//
// You are given an array of positive integers @N.
//
// Write a script to return an array @M where $M[i] is the product of
// all elements of @N except the index $N[i].
//

//
// We first calculate the result for M [0], by multiplying all
// numbers N [1 ..]. Then, for each i > 0, we calculate M [i] as
//
//      M [i] = (M [i - 1] / N [i]) * N [i - 1]
//
// Assuming the challenge is created such that each M [i] fits in an
// integer, this will not result in an overflow, as long as we first do
// the division, then the multiplication.
// Note that N [i] evenly divides M [i - 1] by definition.
//

//
// Node.js doesn't have 64 bit integers. We need to explicitly make numbers
// into BigInt objects to deal with number larger than about 53 bits.
// And Node.js doesn't always cast numbers to BigInts with arithmetic.
//

//
// Read STDIN. Split on newlines, then on whitespace, and turn the results
// into (BigInt) numbers.
//
let lines = require      ("fs")
          . readFileSync (0)                 // Read all.
          . toString     ()                  // Turn it into a string.
          . split        ("\n")              // Split on newlines.
          . filter       (_ => _ . length)   // Filter empty lines.
          . map          (_ => _ . split (" ")               // Split lines
                                                             // on spaces
                                 . map   (_ => BigInt (_)))  // Numify.
;


//
// Iterate over the lines
//
lines . forEach (array => {
    //
    // Get the first product
    //
    let product = array . reduce ((acc, val, idx) => {
        return idx ? acc * val : 1n;
    }, 1);

    //
    // Print it
    //
    process . stdout . write ("" + product);

    //
    // Get the other products
    //
    array . forEach ((val, idx, array) => {
        if (idx) {
            product = product / array [idx];
            product = product * array [idx - 1];
            process . stdout . write (", " + product);
        }
    });

    process . stdout . write ("\n");
});
