#! /usr/bin/node

"use strict"

function incrementdecrement(operations) {
    let p = 0;
    for (let s of operations) {
        if (s.charAt(1) == '+') {
            p += 1;
        } else {
            p -= 1;
        }
    }
    return p;
}

if (incrementdecrement(['--x', 'x++', 'x++']) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (incrementdecrement(['x++', '++x', 'x++']) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (incrementdecrement(['x++', '++x', '--x', 'x--']) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
