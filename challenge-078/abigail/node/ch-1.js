//
// Exercise:
//    You are given an array @A containing distinct integers.
//    Write a script to find all leader elements in the array @A.
//    Print (0) if none found. An element is leader if it is greater
//    than all the elements to its right side.
//

//
// Note:
//    - The only way no leader element can be found is if the array is empty.
//    - We will read the array from STDIN.
//

//
// Read a line from STDIN, turn it into a string, strip off the
// trailing newline (and any leading or trailing whitespace),
// and then split in on spaces. Store the result into an array "arry".
//
let fs   = require ("fs");
let line = fs . readFileSync (0) . toString () . trim ();
let arry = line . split (" ");

if (line . length == 0) {
    //
    // Special case, if the line is empty, output 0
    //
    console . log (0);
}
else {
    //
    // Iterate backwards over the array. Keep track of the largest
    // element so far in an array 'out'. If we find a new largest
    // element, put this first in 'out' (so, the largest element
    // seen so far is always in 'out [0]'.
    //
    let out = [arry [arry . length - 1]];
    for (let i = arry . length - 2; i >= 0; i --) {
        //
        // Note that we have strings in arry (and hence, out). 
        // An unary + casts them to numbers.
        //
        if (+arry [i] > +out [0]) {
            out . unshift (arry [i]);
        }
    }

    //
    // Print the result.
    //
    console . log (out . join (" "));
}
