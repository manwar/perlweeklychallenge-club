#! /usr/bin/node

"use strict"

function oddmatrix(rows, cols, points) {
    let rm = new Set;
    let cm = new Set;
    for (let p of points) {
        if (rm.has(p[0])) {
            rm.delete(p[0]);
        } else {
            rm.add(p[0]);
        }
        if (cm.has(p[1])) {
            cm.delete(p[1]);
        } else {
            cm.add(p[1]);
        }
    }
    return rm.size * (cols - cm.size) + cm.size * (rows - rm.size);
}

if (oddmatrix(2, 3, [[0, 1], [1, 1]]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (oddmatrix(2, 2, [[1, 1], [0, 0]]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (oddmatrix(3, 3, [[0, 0], [1, 2], [2, 1]]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (oddmatrix(1, 5, [[0, 2], [0, 4]]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (oddmatrix(4, 2, [[1, 0], [3, 1], [2, 0], [0, 1]]) == 8) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
