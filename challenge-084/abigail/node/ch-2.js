//
// Read STDIN. Split on newlines, then on whitespace, and turn the results
// into numbers. Since the input will be newline terminated, we have an
// empty line to filter out.
//
let matrix = require      ("fs")
           . readFileSync (0)               // Read a line.
           . toString     ()                // Turn it into a string.
           . split        ("\n")            // Split on newlines.
           . filter       (_ => _)          // Remove empty (trailing) line.
           . map (_ => _ . split (/\s+/)    // Split each line on spaces
                         . map (_ => +_));  // Turn into numbers.

let height = matrix     . length;
let width  = matrix [0] . length;

//
// Use a cubic algorithm to count any squares will all 1s at the corners.
// For each 0 <= x < height, 0 <= y < width, and k > 0 such that x + k < height
// and y + k < width, we add a square if all of the following are true:
//     matrix [x]     [y]
//     matrix [x + k] [y]
//     matrix [x]     [y + k]
//     matrix [x + k] [y + k]
//
let count = 0;
for (let x = 0; x < height; x ++) {
    for (let y = 0; y < width; y ++) {
        if (!matrix [x] [y]) {
            continue;
        }
        for (let k = 1; x + k < height && y + k < width; k ++) {
            if (matrix [x]     [y + k] &&
                matrix [x + k] [y]     &&
                matrix [x + k] [y + k]) {
                count ++
            }
        }
    }
}

//
// Print the result.
//
console . log (count);
