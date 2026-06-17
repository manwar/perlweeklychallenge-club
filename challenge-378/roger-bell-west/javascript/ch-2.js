#! /usr/bin/node

"use strict"

function l2n(a) {
    const a0 = 'a'.charCodeAt(0);
    let t = 0;
    for (let c of a.split("")) {
        t *= 10;
        t += c.charCodeAt(0) - a0;
    }
    return t;
}

function sumofwords(a, b, c) {
    return l2n(a) + l2n(b) == l2n(c);
}

if (sumofwords('acb', 'cba', 'cdb')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sumofwords('aab', 'aac', 'ad')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!sumofwords('bc', 'je', 'jg')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sumofwords('a', 'aaaa', 'aa')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!sumofwords('c', 'd', 'h')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sumofwords('gfi', 'hbf', 'bdhd')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
