#! /usr/bin/node

"use strict"

function matrixscore(matrix0) {
    let matrix = matrix0;
    for (let i = 0; i < matrix.length; i++) {
        if (matrix[i][0] == 0) {
            for (let j = 0; j < matrix[i].length; j++) {
                matrix[i][j] = 1 - matrix[i][j];
            }
        }
    }
    const t = Math.floor(matrix.length / 2);
    for (let i = 1; i < matrix[0].length; i++) {
        let c = 0;
        for (let j = 0; j < matrix.length; j++) {
            if (matrix[j][i] == 0) {
                c += 1;
            }
        }
        if (c > t) {
            for (let j= 0; j < matrix.length; j++) {
                matrix[j][i] = 1 - matrix[j][i];
            }
        }
    }
    let tot = 0;
    for (let m of matrix) {
        let p = 0;
        for (let n of m) {
            p *= 2;
            if (n == 1) {
                p += 1;
            }
        }
        tot += p;
    }
    return tot;
}

if (matrixscore([[0, 0, 1, 1], [1, 0, 1, 0], [1, 1, 1, 0]]) == 39) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (matrixscore([[0]]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
