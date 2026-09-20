#! /usr/bin/node

"use strict"

function arrangebox(a0) {
    let a = a0;
    a.sort(function(i, j) {
        if (i == j) {
            return i[1] - j[1];
        } else {
            return i[0] - j[0];
        }
    });
    let stack = [];
    let mx = 1;
    for (let i = 0; i < a.length; i++) {
        stack.push([i, 1]);
    }
    while (stack.length > 0) {
        const s = stack.pop();
        const ix = s[0];
        const pm = s[1];
        if (pm > mx) {
            mx = pm;
        }
        for (let j = ix + 1; j < a.length; j++) {
            if (a[ix][0] < a[j][0] && a[ix][1] < a[j][1]) {
                stack.push([j, pm + 1]);
            }
        }
    }
    return mx;
}

if (arrangebox([[1, 3], [3, 5], [6, 8], [2, 4]]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arrangebox([[4, 5], [4, 6], [6, 7], [2, 3], [4, 3]]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arrangebox([[5, 5], [5, 5], [5, 5]]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arrangebox([[2, 100], [3, 200], [4, 300], [5, 50], [5, 400]]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arrangebox([[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
