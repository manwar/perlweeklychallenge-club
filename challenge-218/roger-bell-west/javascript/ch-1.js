#! /usr/bin/node

function maximumproduct(lst) {
    let l = lst;
    l.sort(function(a,b) {
        return a-b;
    });
    const b = l.length;
    let t = [];
    for (let i = 0; i <= 3; i++) {
        let p = 1;
        if (i > 0) {
            for (let j = 0; j < i; j++) {
                p *= l[j];
            }
        }
        if (i < 3) {
            for (let j = b - 3 + i; j < b; j++) {
                p *= l[j];
            }
        }
        t.push(p);
    }
    return Math.max(...t);
}

"use strict"

if (maximumproduct([3, 1, 2]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximumproduct([4, 1, 3, 2]) == 24) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximumproduct([-1, 0, 1, 3, 1]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximumproduct([-8, 2, -9, 0, -4, 3]) == 216) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
