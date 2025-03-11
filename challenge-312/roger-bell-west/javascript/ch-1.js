#! /usr/bin/node

function transfer(a, b) {
    const ac = a.charCodeAt(0);
    const bc = b.charCodeAt(0);
    return Math.min((ac - bc + 26) % 26, (bc - ac + 26) % 26);
}

function minimumtime(a) {
    let tot = a.length;
    let prev = 'a';
    for (let c of a.split('')) {
        tot += transfer(prev, c);
        prev = c;
    }
    return tot;
}

"use strict"

if (minimumtime('abc') == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (minimumtime('bza') == 7) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (minimumtime('zjpc') == 34) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
