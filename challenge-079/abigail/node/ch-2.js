//
// Challenge:
//
//    You are given an array of positive numbers @N.
//    Write a script to represent it as Histogram Chart and find out
//    how much water it can trap.
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
    print_histogram (line);
});


//
// Node doesn't have (s)printf, so we're writing our own formatting function.
//
function ff (n, width, pad = " ") {
    let s = n . toString ();
    while (s . length < width) {
        s = pad + s;
    }
    return s;
}

function print_histogram (input) {
    //
    // Extract N from the input, find the maximum,
    // and the width of this maximum.
    //
    let N   = input . split (" ") . map (Number);
    let max = Math  . max (... N);
    let w   = max   . toString () . length;

    //
    // Count down volumes from the maximum, down to 1.
    // For each volume, print the volume, and for each entry
    // in N, print "#" if the volume is equal or less than
    // the entry in N, else, print " ". 
    //
    for (let volume = max; volume; volume --) {
        let line = ff (volume, w);
        for (let i = 0; i < N . length; i ++) {
            line += " " + ff (volume <= N [i] ? "#" : " ", w);
        }
        console . log (line);
    }

    //
    // Print the bars
    //
    let line = "";
    line += ff ("_", w, "_");
    for (let i = 0; i < N . length; i ++) {
        line += " " + ff ("_", w, "_");
    }
    console . log (line);

    //
    // Finally, print the totals
    //
    line = "";
    line += ff (" ", w);
    for (let i = 0; i < N . length; i ++) {
        line += " " + ff (N [i], w);
    }
    console . log (line);
}
