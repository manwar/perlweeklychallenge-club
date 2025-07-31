#! /usr/bin/node

"use strict"

function counterify(a) {
    let cc = new Map;
    for (let x of a) {
        if (!cc.has(x)) {
            cc.set(x, 0);
        }
        cc.set(x, cc.get(x) + 1);
    }
    return cc;
}

function oddletters(a) {
    const c = counterify(a);
    for (let v of c.values()) {
        if (v % 2 == 0) {
            return false;
        }
    }
    return true;
}

if (!oddletters('weekly')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (oddletters('perl')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!oddletters('challenge')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
