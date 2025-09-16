#! /usr/bin/node

function maxdiff(a) {
    let md = 0;
    for (let w = 0; w < a.length - 1; w++) {
        for (let x = w + 1; x < a.length; x++) {
            for (let y = w + 1; y < a.length - 1; y++) {
                if (y != x) {
                    for (let z = y + 1; z < a.length; z++) {
                        if (z != x) {
                            const v = Math.abs(a[w] * a[x] - a[y] * a[z]);
                            md = Math.max(md, v)
                        }
                    }
                }
            }
        }
    }
    return md;
}-

"use strict"

if (maxdiff([5, 9, 3, 4, 6]) == 42) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxdiff([1, -2, 3, -4]) == 10) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxdiff([-3, -1, -2, -4]) == 10) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxdiff([10, 2, 0, 5, 1]) == 50) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxdiff([7, 8, 9, 10, 10]) == 44) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
