#! /usr/bin/node

"use strict"

function arrangebinary(a, n) {
    let b = [...a];
    let t = n;
    for (let i = 0; i < b.length; i++) {
        if (b[i] == 0 &&
            (i == 0 || b[i - 1] == 0) &&
            (i == b.length - 1 || b[i + 1] == 0)) {
            b[i] = 1;
            t -= 1;
            if (t == 0) {
                break;
            }
        }
    }
    return t == 0;
}

if (arrangebinary([1, 0, 0, 0, 1], 1)) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!arrangebinary([1, 0, 0, 0, 1], 2)) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
