#! /usr/bin/node

"use strict"

function toeplitzmatrix(a) {
    let ym = a.length - 1;
    let xm = a[0].length - 1;
    let toeplitz = true;
    for (let xb = 1 - xm; xb <= ym - 1; xb++) {
        let init = true;
        let tv = 0;
        for (let x = xb; x <= xb + xm; x++) {
            if (x >= 0 && x <= xm) {
                let y = x - xb;
                if (y >= 0 && y <= ym) {
                    if (init) {
                        init = false;
                        tv = a[y][x];
                    } else if (a[y][x] != tv) {
                        toeplitz = false;
                        break;
                    }
                }
            }
        }
        if (!toeplitz) {
            break;
        }
    }
    return toeplitz
}

if (toeplitzmatrix([[4, 3, 2, 1], [5, 4, 3, 2], [6, 5, 4, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!toeplitzmatrix([[1, 2, 3], [3, 2, 1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
