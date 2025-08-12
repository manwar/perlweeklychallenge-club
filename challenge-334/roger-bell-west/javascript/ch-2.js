#! /usr/bin/node

"use strict"

function nearestvalidpoint(x, y, points) {
    let ix = -1;
    let minmhd = -1;
    points.forEach((p, i) => {
        if (p[0] == x || p[1] == y) {
            const mhd = Math.abs(p[0] - x) + Math.abs(p[1] - y);
            if (minmhd == -1 || mhd < minmhd) {
                minmhd = mhd;
                ix = i;
            }
        }
    });
    return ix;
}

if (nearestvalidpoint(3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (nearestvalidpoint(2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (nearestvalidpoint(1, 1, [[2, 2], [3, 3], [4, 4]]) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (nearestvalidpoint(0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (nearestvalidpoint(5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
