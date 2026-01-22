#! /usr/bin/node

"use strict"

function a2n(a) {
    let t = 0;
    for (let d of a) {
        t *= 10;
        t += d;
    }
    return t;
}

function kaprekarconstant(a) {
    let ct = 0;
    let b = a;
    while (b != 6174) {
        if (b == 0) {
            return -1;
        }
        let digits = [];
        for (let i = 0; i <= 3; i++) {
            digits.push(b % 10);
            b = Math.floor(b / 10);
        }
        digits.sort(function(a,b) {
            return a-b;
        });
        let stigid = [...digits];
        stigid.reverse();
        b = a2n(stigid) - a2n(digits);
        ct += 1;
    }
    return ct;
}

if (kaprekarconstant(3524) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (kaprekarconstant(6174) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (kaprekarconstant(9998) == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (kaprekarconstant(1001) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (kaprekarconstant(9000) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (kaprekarconstant(1111) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
