#! /usr/bin/node

"use strict"

function threepower(n0) {
    if (n0 == 0) {
        return false;
    }
    let n = Math.abs(n0);
    let lo = 1;
    let hi = Math.floor(n / 2);
    while (true) {
        const t = Math.floor((lo + hi) / 2);
        const c = t * t * t;
        if (c == n) {
            return true;
        }
        if (lo == t) {
            return false;
        }
        if (c < n) {
            lo = t;
        } else {
            hi = t;
        }
    }
}

if (threepower(27)) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!threepower(0)) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!threepower(6)) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
