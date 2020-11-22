//
// Challenge
//
// You are given an unsorted array of integers @N.
//
// Write a script to find the longest consecutive sequence. Print 0 if
// none sequence found.
//

//
// For notes, see the perl solution: ../perl/ch-1.pl
//

//
// After reading the input, we put the numbers both in an array
// (called "array") and an object (called "set").
// We iterate over the array. If the element has been deleted
// from the set, we continue with the next element.
// Else, we construct the longest sequence this element is part
// off, by starting with the range containing just this element,
// and extending it on both sides as long as the extension is
// in the set. We then check whether this improves the best range
// seen so far (and update the best range), and delete the sequence
// from the set.
//
// When we have processed all numbers, we print the best sequence.
//


//
// Read STDIN. Split on newlines, then on whitespace, and turn the results
// into numbers.
//
let lines = require      ("fs")
          . readFileSync (0)               // Read all.
          . toString     ()                // Turn it into a string.
          . split        ("\n")            // Split on newlines.
;


//
// Iterate over the lines
//
for (let i = 0; i < lines . length - 1; i ++) {
    //
    // The line is a set of integers, split on
    // white space, and store the numbers in a hash.
    //
    let array = lines [i] . split (" ") . map (_ => +_);
    let set   = array . reduce ((acc, val) => {
        acc [val] = 1;
        return acc;
    }, {});

    let best = [0, 0];
    for (let i = 0; i < array . length; i ++) {
        let low  = array [i];
        if (!set [low]) {
            continue; // Skip if it's no longer in the set.
        }
        let high = low;
        while (set [low - 1]) {
            low --;
        }
        while (set [high + 1]) {
            high ++;
        }
        if (low < high  &&    // Exclude sequences of length 1
            high - low > best [1] - best [0]) {
            best = [low, high];
        }
        for (let i = low; i <= high; i ++) {
            set [i] = 0;
        }
    }

    //
    // Output
    //
    let str = "";
    for (let i = best [0]; i <= best [1]; i ++) {
        str += i;
        if (i < best [1]) {
            str += ", ";
        }
    }
    console . log (str);
}
