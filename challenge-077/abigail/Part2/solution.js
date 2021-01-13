//
// Exercise:
//    You are given m x n character matrix consists of O and X only.
//    Write a script to count the total number of X surrounded by O only.
//    Print 0 if none found.
//

//
// Read in the board:
//    - Read STDIN
//    - Split by newlines
//    - Split each line on spaces
//    - Map an 'X' to a 1, 'O' to a 0.
//    - Add a 0 to the beginning and end of each line.
//
let fs    = require ("fs");
let board = fs . readFileSync (0) . toString () . trim () . split ("\n") .
            map (line => (line . split (" ")) . map (c => c == "X" ? 1 : 0)) .
            map (line => ([0] . concat (line) . concat ([0])));

//
// Add top and bottom with 0s
//
board . push    (board [0] . map (x => 0));
board . unshift (board [0] . map (x => 0));

let count = 0;

//
// Iterate over the cells of the board board, skipping cells on the edge
// (as we added them). For each 1, check the 8 cells surrounding the cell
// (this will never be outside of the board). If one of the neighbouring
// cells is a 1, move on the next cell. If no neighbouring cell is 1,
// we add 1 to the count.
//
for (let x = 1; x < board . length - 1; x ++) {
  ELEMENT:
    for (let y = 1; y < board [x] . length - 1; y ++) {
        if (!board [x] [y]) {
            continue;
        }
        for (let dx = -1; dx <= 1; dx ++) {
            for (let dy = -1; dy <= 1; dy ++) {
                if (dx == 0 && dy == 0) {
                    continue;
                }
                if (board [x + dx] [y + dy]) {
                    continue ELEMENT;
                }
            }
        }
        count ++;
    }
}


//
// Print the results.
//
console . log (count);
