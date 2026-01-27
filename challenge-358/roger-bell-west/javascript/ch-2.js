#! /usr/bin/node

"use strict"

function posmod(x, y) {
  let z = x % y;
  while (z < 0) {
    z += y;
  }
  return z;
}


function rotx(a, offset) {
    let o = posmod(offset, 26);
    let base;
    if (a >= 'a' && a <= 'z') {
        base = 'a'.charCodeAt(0);
    } else if (a >= 'A' && a <= 'Z') {
        base = 'A'.charCodeAt(0);
    } else {
        return a;
    }
    let c = posmod(a.charCodeAt(0) - base + o, 26) + base;
    return String.fromCharCode(c);
}

function encryptedstring(a, offset) {
    return a.split('').map(x => rotx(x, offset)).join('');
}

if (encryptedstring('abc', 1) == 'bcd') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (encryptedstring('xyz', 2) == 'zab') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (encryptedstring('abc', 27) == 'bcd') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (encryptedstring('hello', 5) == 'mjqqt') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (encryptedstring('perl', 26) == 'perl') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
