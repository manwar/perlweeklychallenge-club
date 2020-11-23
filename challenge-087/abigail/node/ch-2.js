//
// Challenge
//
// You are given matrix m x n with 0 and 1.
//
// Write a script to find the largest rectangle containing only 1.
// Print 0 if none found.
//

//
// For notes, see the perl solution: ../perl/ch-1.pl
//

//
// A naive implementation would be a for each pair of points see whether
// there's a rectangle with 1s, with the pair of points opposite vertices
// of the array.
//
// If done correctly, that leads to an Omega (l^2 * m^2) algorithm,
// if the size of the input is an l x m matrix. So, Omega (N^2)
// where N = l * m.
//
// But we can do better. We can use an algorithm which runs in
// O (l * m * min (l, m)) time, or O (N sqrt (N)) time, since
// min (l, m) <= sqrt (N).
//
// Assume the matrix is not wider than it is high (otherwise, first
// transpose the matrix -- which can be done in O (l * m) time).
//
// First, we replace every 1 in the matrix with how many 1's (including
// the 1 in the current position) it takes the hit the first 0 below it.
// We can do this in a single pass, working bottom to top.
//
// So, the matrix 
//
//          0 1 0 1 1
//          0 1 0 1 1
//          0 1 1 1 1
//          1 0 0 1 1
//          0 0 0 1 1
//          0 0 1 0 0
//
// becomes
//
//          0 3 0 5 5
//          0 2 0 4 4
//          0 1 1 3 3
//          1 0 0 2 2
//          0 0 0 1 1
//          0 0 1 0 0
//
// Then, for each cell (x, y) in the matrix, we scan to the right (in the
// y direction), until we hit a zero (or the end of the row). For each 
// cell (x, y + k) in the scan, we keep track of the minimum value in
// points (x, y + m), 0 <= m <= k, as calculated in the step above.
// Let this value be p. Then the maximum sized rectangle we can make
// with the points (x, y) and (x, y + k) as (top) vertices of that
// rectangle is (k + 1) x p.
//


//
// Read STDIN. Split on newlines, then on whitespace, and turn the results
// into numbers.
//
let matrix = require      ("fs")
           . readFileSync (0)                 // Read all.
           . toString     ()                  // Turn it into a string.
           . split        ("\n")              // Split on newlines.
           . filter       (_ => _ . length)   // Filter empty lines.
           . map          (_ => _ . split (" ")       // Split lines on spaces
                                  . map   (_ => +_))  // Numify.
;

//
// Check whether all rows are the same size
//
for (let x = 1; x < matrix . length; x ++) {
    if (matrix [x] . length != matrix [0] . length) {
        process . stderr . write ("Not all rows are equal!\n");
        process . exit (1);
    }
}

let X = matrix     . length;
let Y = matrix [0] . length;

//
// Transpose if the matrix is wider than it is high.
//
let transposed = 0;
if (X < Y) {
    matrix = matrix [0] . map ((col, i) => matrix . map (row => row [i]));
    [X, Y] = [Y, X];
    transposed = 1;
}

//
// Maps the 1s in the matrix to the number of consecutive 1s below
// it (including this 1 itself).
//
for (let x = X - 2; x >= 0; x --) {
    for (let y = 0; y < Y; y ++) {
        matrix [x] [y] = matrix [x]     [y] *
                        (matrix [x + 1] [y] + 1);
    }
}


//
// Iterate over all element of the matrix. For each element which
// isn't 0, scan to the right, keeping track of minimum sequence
// downward. For each point in the scan, find the largest rectangle
// which can be made with these points as corner points.
//
// Remember the best one found.
//
let best = [0, 0];
for (let x = 0; x < X; x ++) {
    for (let y = 0; y < Y; y ++) {
        if (matrix [x] [y] == 0) {
            continue;
        }
        let min_depth = matrix [x] [y];
        if (min_depth > best [0] * best [1]) {
            best = [min_depth, 1];
        }
        for (w = 1; y + w < Y &&
                    matrix [x] [y + w] > 0; w ++) {
            if (matrix [x] [y + w] < min_depth) {
                min_depth = matrix [x] [y + w];
            }
            if (min_depth * (w + 1) > best [0] * best [1]) {
                best = [min_depth, w + 1];
            }
        }
    }
}


//
// Print solution. 
//
let output = "0";
if (best [0] * best [1] > 1) {
    if (transposed) {
        best = [best [1], best [0]];
    }
    let row = [... Array (best [1]) . keys ()] . map (_ => 1)   . join (" ");
    output  = [... Array (best [0]) . keys ()] . map (_ => row) . join ("\n");
}

console . log (output);

