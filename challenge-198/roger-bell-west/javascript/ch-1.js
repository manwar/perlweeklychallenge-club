#! /usr/bin/node

"use strict"

function maxgap(l0) {
    if (l0.length < 2) {
        return 0;
    }
    let l = l0;
    l.sort();
    let q = [];
    for (let i = 0; i < l.length - 1; i++) {
        q.push(l[i + 1] - l[i]);
    }
    let mq = Math.max(...q);
    return q.filter(i => i == mq).length;
}

if (maxgap([2, 5, 8, 1]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (maxgap([3]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
