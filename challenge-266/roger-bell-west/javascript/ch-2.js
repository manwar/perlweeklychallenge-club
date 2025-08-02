#! /usr/bin/node

"use strict"

function xmatrix(a) {
    const order = a.length - 1;
    let valid = true;
    a.forEach((row, y) => {
        row.forEach((value, x) => {
            if (x == y || x == order - y) {
                if (value == 0) {
                    valid = false;
                }
            } else {
                if (value != 0) {
                    valid = false;
                }
            }
        })
    });
    return valid;
}

if (xmatrix([[1, 0, 0, 2], [0, 3, 4, 0], [0, 5, 6, 0], [7, 0, 0, 1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!xmatrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (xmatrix([[1, 0, 2], [0, 3, 0], [4, 0, 5]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
