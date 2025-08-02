#! /usr/bin/node

"use strict"

function uniquenumber(a) {
    let c = new Map();
    for (let p of a) {
        if (c.has(p)) {
            c.set(p,c.get(p)+1);
        } else {
            c.set(p,1);
        }
    }
    for (let p of c.keys()) {
        if (c.get(p) == 1) {
            return p;
        }
    }
    return -1;
}

if (uniquenumber([3, 3, 1]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (uniquenumber([3, 2, 4, 2, 4]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (uniquenumber([1]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (uniquenumber([4, 3, 1, 1, 1, 4]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
