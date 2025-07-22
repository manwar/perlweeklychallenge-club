#! /usr/bin/node

"use strict"

function lastword(a) {
    let w = a.split(" ").filter(i => i.length > 0);
    return w[w.length - 1].length;
}

if (lastword('The Weekly Challenge') == 9) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (lastword('   Hello   World    ') == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (lastword("Let's begin the fun") == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
