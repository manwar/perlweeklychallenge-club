#! /usr/bin/node

"use strict"

function defrangip(a) {
    return a.replace(/\./g, "[.]");
}

if (defrangip('1.1.1.1') == '1[.]1[.]1[.]1') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (defrangip('255.101.1.0') == '255[.]101[.]1[.]0') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
