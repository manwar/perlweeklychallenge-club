#! /usr/bin/node

"use strict"

function strvalue(a) {
    let n = parseInt(a, 10);
    if (isNaN(n)) {
        return a.length;
    } else {
        return n;
    }
}

function maxstrvalue(a) {
    return Math.max(...a.map(x => strvalue(x)));
}

if (maxstrvalue(['123', '45', '6']) == 123) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxstrvalue(['abc', 'de', 'fghi']) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxstrvalue(['0012', '99', 'a1b2c']) == 99) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxstrvalue(['x', '10', 'xyz', '007']) == 10) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxstrvalue(['hello123', '2026', 'perl']) == 2026) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
