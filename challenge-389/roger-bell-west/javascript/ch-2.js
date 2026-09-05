#! /usr/bin/node

"use strict"

function zigzagsubarray(a) {
    let mx = Math.min(1, a.length);
    for (let i = 0; i < a.length; i++) {
        let o = 0;
        let lastdir = 0;
        for (let j = i; j < a.length; j++) {
            let thisdir = 0;
            if (j > i) {
                if (a[j] > o) {
                    thisdir = 1;
                    mx = Math.max(mx, 2);
                } else if (a[j] < o) {
                    thisdir = -1;
                    mx = Math.max(mx, 2);
                }
            }
            if ((j > i && thisdir == 0) || (j > i + 1 && thisdir * lastdir != -1)) {
                break;
            }
            o = a[j];
            lastdir = thisdir;
            mx = Math.max(mx, j - i + 1);
        }
    }
    return mx;
}

if (zigzagsubarray([9, 4, 2, 10, 7, 8, 8, 1, 9]) == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (zigzagsubarray([1, 7, 4, 9, 2, 5]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (zigzagsubarray([1, 2, 3, 4, 5]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (zigzagsubarray([4, 4, 4]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (zigzagsubarray([10, 20, 15, 12, 18]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
