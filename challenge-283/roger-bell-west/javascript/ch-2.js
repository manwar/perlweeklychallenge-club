#! /usr/bin/node

"use strict"

function digitcountvalue(a) {
    let c = new Map();
    for (let ix = 0; ix < a.length; ix++) {
        c.set(ix, 0);
    }
    for (let p of a) {
        c.set(p, c.get(p) + 1);
    }
    for (let ix = 0; ix < a.length; ix++) {
        if (a[ix] != c.get(ix)) {
            return false;
        }
    }
    return true;
}

if (digitcountvalue([1, 2, 1, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!digitcountvalue([0, 3, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
