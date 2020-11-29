//
// Challenge
//
// You are given m x n matrix of positive integers.
// 
// Write a script to print spiral matrix as list.
// 

//
// We solve this by keeping track of the boundaries (min_x, min_y, max_x,
// max_y) of the part of the matrix which still needs to be processed.
// Initially, min_x and min_y are 0, max_x is the index of the bottom row,
// and max_y is the index of the right most column.
//
// We then process the matrix side by side, first going east (top row), 
// south (left column), west (bottom row), then north (left row). After
// doing a side, we update the corresponding min/max value. That is,
// after doing the top row, we increment min_x; right column, decrement
// max_y; bottom row, decrement max_x; left column, increment min_y.
//
// We're done when min_x > max_x, or min_y > max_y.
//

//
// Read STDIN. Split on newlines, then on white space.
//
let matrix = require      ("fs")
           . readFileSync (0)                       // Read all.
           . toString     ()                        // Turn it into a string.
           . split        ("\n")                    // Split on newlines.
           . filter       (_ => _ . length)         // Filter empty lines.
           . map          (_ => _ . trim ()         // Trim white space.
                                 . split (/\s+/))  // Split on whitespace.
;

//
// Check if all rows are the same length
//
matrix . forEach (row => {
    if (row . length != matrix [0] . length) {
        throw "Not all rows are of equal length";
    }
});

//
// Set some variables
//
let EAST      = 0;
let SOUTH     = 1;
let WEST      = 2;
let NORTH     = 3;

let direction = EAST;  // Initial direction

let min_x     = 0;
let max_x     = matrix     . length - 1;
let min_y     = 0;
let max_y     = matrix [0] . length - 1;

//
// Spiral down the matrix, putting the results into the string output.
//
let output = "";
while (min_x <= max_x && min_y <= max_y) {
    if (direction == EAST) {
        for (let y = min_y; y <= max_y; y ++) {
            output = output + ", " + matrix [min_x] [y];
        }
        min_x ++;
    }
    if (direction == SOUTH) {
        for (let x = min_x; x <= max_x; x ++) {
            output = output + ", " + matrix [x] [max_y];
        }
        max_y --;
    }
    if (direction == WEST) {
        for (let y = max_y; y >= min_y; y --) {
            output = output + ", " + matrix [max_x] [y];
        }
        max_x --;
    }
    if (direction == NORTH) {
        for (let x = max_x; x >= min_x; x --) {
            output = output + ", " + matrix [x] [min_y];
        }
        min_y ++;
    }

    direction = (direction + 1) % (NORTH + 1);
}

//
// Print the result, without the leading ", ".
//
process . stdout . write (output . slice (2) + "\n");
