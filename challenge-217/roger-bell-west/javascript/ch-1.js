#! /usr/bin/node

"use strict"

function sortedmatrix(matrix) {
    var n = matrix.flat();
    n.sort();
    return n[2];
}

if (sortedmatrix([[3, 1, 2], [5, 2, 4], [0, 1, 3]]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sortedmatrix([[2, 1], [4, 5]]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sortedmatrix([[1, 0, 3], [0, 0, 0], [1, 2, 1]]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
