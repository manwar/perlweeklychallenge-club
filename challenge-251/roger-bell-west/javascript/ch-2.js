#! /usr/bin/node

"use strict"

function luckynumbers (a) {
    var maxs = new Set();
    for (let x = 0; x < a[0].length; x++) {
        var max = [0, 0, 0];
        for (let y = 0; y < a.length; y++) {
            if (a[y][x] > max[0]) {
                max = [a[y][x], y, x];
            }
        }
        maxs.add(max);
    }
    var mins = new Set();
    for (let y = 0; y < a.length; y++) {
        var min = [a[y][0], y, 0];
        for (let x = 0; x < a[0].length; x++) {
            if (a[y][x] < min[0]) {
                min = [a[y][x], y, x];
            }
        }
        mins.add(min);
    }
    for (let i of maxs) {
        for (let j of mins) {
            if (i[0] == j[0] && i[1] == j[1] && i[2] == j[2]) {
                return i[0];
            }
        }
    }
    return -1;
}

if (luckynumbers([[3, 7, 9], [9, 11, 13], [15, 16, 17]]) == 15) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (luckynumbers([[1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]]) == 12) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (luckynumbers([[7, 8], [1, 2]]) == 7) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
