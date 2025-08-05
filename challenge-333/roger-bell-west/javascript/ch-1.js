#! /usr/bin/node

"use strict"

function straightline(a) {
    let b = [];
    for (let xy of a) {
        let u = true;
        for (let bxy of b) {
            if (xy[0] == bxy[0] && xy[1] == bxy[1]) {
                u = false;
                break;
            }
        }
        if (u) {
            b.push(xy);
        }
    }
    if (b.length < 3) {
        return true;
    }
    const p = b[0][0];
    const q = b[1][0] - b[0][0];
    const r = b[0][1];
    const s = b[1][1] - b[0][1];
    for (let tp = 2; tp < b.length; b++) {
        const tpair = b[tp];
        if (q == 0 && tpair[0] != b[0][0]) {
            return false;
        }
        if (s == 0 && tpair[1] != b[0][1]) {
            return false;
        }
        if (q != 0 && s != 0) {
            const n1 = (tpair[0] - p ) / q;
            const n2 = (tpair[1] - r ) / s;
            if (n1 != n2) {
                return false;
            }
        }
    }
    return true;
}

if (straightline([[2, 1], [2, 3], [2, 5]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (straightline([[1, 4], [3, 4], [10, 4]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!straightline([[0, 0], [1, 1], [2, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (straightline([[1, 1], [1, 1], [1, 1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
