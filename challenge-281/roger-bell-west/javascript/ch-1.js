#! /usr/bin/node

"use strict"

function cs2xy(a) {
    const x = a.charCodeAt(0) - 'a'.charCodeAt(0);
    const y = a.charCodeAt(1) - '1'.charCodeAt(0);
    return [x, y];
}

function checkcolor(a) {
    const xy = cs2xy(a);
    return (xy[0] + xy[1]) % 2 == 1;
}

if (checkcolor('d3')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!checkcolor('g5')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (checkcolor('e6')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
