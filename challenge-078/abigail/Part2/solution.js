//
// Exercise:
// 
//   You are given array @A containing positive numbers and @B containing
//   one or more indices from the array @A.
//   Write a script to left rotate @A so that the number at the first index
//   of @B becomes the first element in the array. Similary, left rotate @A
//   again so that the number at the second index of @B becomes the first
//   element in the array.
//
// We will be reading the arrays from STDIN -- @A is one the first
// line, @B is on the second line.
//

//
// Read two lines from STDIN, turn it into a string, strip off the
// trailing newline (and any leading or trailing whitespace),
// and then split in on spaces. Store the result into an arrays A and B.
//
let fs    = require ("fs");
let lines = fs . readFileSync (0) . toString () . split ("\n");
let A     = lines [0] . trim () . split (" ");
let B     = lines [1] . trim () . split (" ");


//
// Iterate over the array B, and print the slices of A.
//
for (let i = 0; i < B . length; i ++) {
    let index = +B [i];
    console . log (A . slice (   index) . join (" ") + " " +
                   A . slice (0, index) . join (" "));
}
