#! /usr/bin/node

"use strict"

function alphanumericstringvalue(a) {
    let l = [];
    for (let n of a) {
        let p = 1 * n;
        if (Number.isNaN(p)) {
            p = n.length;
        }
        l.push(p);
    }
    return Math.max(...l);
}

if (alphanumericstringvalue(['perl', "2", "000", 'python', 'raku']) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (alphanumericstringvalue(["001", "1", "000", "0001"]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
