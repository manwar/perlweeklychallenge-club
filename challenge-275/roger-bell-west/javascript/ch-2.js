#! /usr/bin/node

"use strict"

function replacedigits(a) {
    let out = "";
    let prev = 0;
    for (let c of a.split("")) {
        if (c >= '0' && c <= '9') {
            out += String.fromCharCode(prev + parseInt(c, 10));
        } else {
            prev = c.charCodeAt(0);
            out += c;
        }
    }
    return out;
}

if (replacedigits('a1c1e1') == 'abcdef') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (replacedigits('a1b2c3d4') == 'abbdcfdh') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (replacedigits('b2b') == 'bdb') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (replacedigits('a16z') == 'abgz') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
