#! /usr/bin/node

"use strict"

function largestsubstring(a) {
    let cc = a.split("");
    for (let offset = cc.length - 1; offset > 0; offset--) {
        for (let x = 0; x < cc.length - offset; x++) {
            if (cc[x] == cc[x + offset]) {
                return offset - 1;
            }
        }
    }
    return -1;
}

if (largestsubstring('aaaaa') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (largestsubstring('abcdeba') == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (largestsubstring('abbc') == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (largestsubstring('abcaacbc') == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (largestsubstring('laptop') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
