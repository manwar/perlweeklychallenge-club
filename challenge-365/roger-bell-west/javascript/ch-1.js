#! /usr/bin/node

"use strict"

function alphabetindexdigitsum(a, k) {
    let st = "";
    for (let c of a.split("")) {
        st += (c.charCodeAt(0) - 96);
    }
    let v = 0 + st;
    for (let _dummy = 0; _dummy < k; _dummy++) {
        let j = 0;
        while (v > 0) {
            j += v % 10;
            v = Math.floor(v / 10);
        }
        v = j;
    }
    return v;
}

if (alphabetindexdigitsum('abc', 1) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (alphabetindexdigitsum('az', 2) == 9) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (alphabetindexdigitsum('cat', 1) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (alphabetindexdigitsum('dog', 2) == 8) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (alphabetindexdigitsum('perl', 3) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
