//
// You are given an integer $N.
//
// Write a script to reverse the given integer and print the result.
// Print 0 if the result doesn't fit in 32-bit signed integer.
// 
// The number 2,147,483,647 is the maximum positive value for a 32-bit
// signed binary integer in computing.
// 

//
// Note that the largest *positive* value which can fit in a
// 32 bit integer is 2,147,483,647, but the largest *negative*
// value is -2,147,483,648.
//

//
// Create an interface to read from STDIN
//
const rl = require ('readline') . createInterface ({
    input:  process . stdin,
});
 
//
// Read lines of input, calculate the result, and print it.
// 
rl . on ('line', (line) => {
    console . log (do_reverse (line));
});


function do_reverse (line) {
    let sign = "";
    //
    // Strip off a leading hyphen; remember if we did so.
    //
    if (line . substring (0, 1) == "-") {
        line = line . substring (1);
        sign = "-";
    }

    //
    // Reverse the digits.
    //
    let enil = sign + line . split ("") . reverse () . join ("");

    //
    // Turn the result into a bigint, so we can safely treat it
    // as a number.
    //
    let result = BigInt (enil);

    //
    // If the result is too large (or too small), return 0.
    // Else, return elin. Note that we should not return result;
    // since result is a BigInt, printing it adds a trailing 'n'.
    //
    return result > 2147483647 || result < -2147483648 ? 0 : enil;
}
