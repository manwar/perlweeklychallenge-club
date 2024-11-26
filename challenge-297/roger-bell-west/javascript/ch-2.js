#! /usr/bin/node

"use strict"

function semiorderedpermutation(a) {
    const en = a.length;
    let s = 1;
    let e = en - 1;
    a.forEach((n, i) => {
        if (n == 1) {
            s = i;
        }
        if (n == en) {
            e = i;
        }
    });
    let r = s + (en - 1 - e);
    if (s > e) {
        r -= 1;
    }
    return r;
}

if (semiorderedpermutation([2, 1, 4, 3]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (semiorderedpermutation([2, 4, 1, 3]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (semiorderedpermutation([1, 3, 2, 4, 5]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
