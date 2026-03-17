#! /usr/bin/node

"use strict"

function decryptstring(a) {
    let out = "";
    const c = a.split("");
    let s = 0;
    while (s < c.length) {
        let m = parseInt(c[s], 10);
        if (s + 2 < c.length && c[s + 2] == '#') {
            m = m * 10 + parseInt(c[s + 1], 10);
            s += 2;
        }
        s += 1;
        out += String.fromCharCode(96 + m);
    }
    return out
}

if (decryptstring('10#11#12') == 'jkab') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (decryptstring('1326#') == 'acz') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (decryptstring('25#24#123') == 'yxabc') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (decryptstring('20#5') == 'te') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (decryptstring('1910#26#') == 'aijz') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
  }
process.stdout.write("\n");
